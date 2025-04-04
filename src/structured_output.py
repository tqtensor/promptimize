from datetime import datetime
from os import getenv

import instructor
from dotenv import load_dotenv
from openai import OpenAI
from pydantic import BaseModel, Field

load_dotenv()


# Define your desired output structure
class Person(BaseModel):
    name: str = Field(description="The person's full name")
    date_of_birth: datetime = Field(
        description="The person's date of birth in ISO 8601 format (YYYY-MM-DD)"
    )
    occupation: str = Field(description="The person's current job or profession")


if __name__ == "__main__":
    # Patch the OpenAI client
    client = instructor.from_openai(
        client=OpenAI(
            api_key=getenv("OPENROUTER_API_KEY"),
            base_url=getenv("OPENROUTER_BASE_URL"),
        ),
        mode=instructor.Mode.MD_JSON,
    )

    # Extract structured data from natural language
    person = client.chat.completions.create(
        model="amazon/nova-pro-v1",
        response_model=Person,
        messages=[
            {"role": "user", "content": "Can you tell me about Harry Potter's profile?"}
        ],
    )

    print(person.name)
    print(person.date_of_birth)
    print(person.occupation)
