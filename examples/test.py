import time
import swagger_client
from swagger_client.rest import ApiException
from pprint import pprint
# create an instance of the API class
api_instance = swagger_client.GrafeasApi()
projects_id = 'projects_id_example' # str | Part of `parent`. This field contains the projectId for example: \"project/{project_id}
note_id = 'note_id_example' # str | The ID to use for this note. (optional)
note = swagger_client.Note() # Note | The Note to be inserted (optional)

try:
    api_response = api_instance.create_note(projects_id=projects_id, note_id=note_id, note=note)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling GrafeasApi->create_note: %s\n" % e)
