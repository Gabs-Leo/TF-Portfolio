#!/usr/bin/env python

from google.cloud import secretmanager
import google_crc32c

def access_secret_version(
    project_id: str, secret_id: str, version_id: str
) -> secretmanager.AccessSecretVersionResponse:

    client = secretmanager.SecretManagerServiceClient()
    name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"
    response = client.access_secret_version(request={"name": name})

    crc32c = google_crc32c.Checksum()
    crc32c.update(response.payload.data)
    if response.payload.data_crc32c != int(crc32c.hexdigest(), 16):
        print("Data corruption detected.")
        return response

    payload = response.payload.data.decode("UTF-8")
    #print(payload)

    #text_file = open("./.env", "w")
    #text_file.write(payload)
    #text_file.close()
    return response

if __name__ == "__main__":
    access_secret_version("gabsleo", "gabsleo-secret-prod", "2")