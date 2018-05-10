import time
import swagger_client
from swagger_client.rest import ApiException
from pprint import pprint
# create an instance of the API class


api_client = swagger_client.ApiClient(host="http://localhost:8080")
api_instance = swagger_client.GrafeasApi(api_client)

try:
    projects_id = 'projects_id_example'  # str | Part of `parent`. This field contains the projectId for example: \"project/{project_id}
    note_id = 'note_id_example'  # str | The ID to use for this note. (optional)

    # occurrence = swagger_client.Occurrence(name='projects/project_one/occurrences/occurrence_one', note_name='note_one')
    # api_response = api_instance.create_occurrence('project_one', occurrence=occurrence)

    # Create a note in this format
    # format: = fmt.Sprintf("%s/{project_id}/%s/{entity_id}", projectKeyword, resourceKeyword)
    note = swagger_client.Note(name='projects/project_one/notes/note_one')  # Note | The Note to be inserted (optional)

    api_response = api_instance.create_note('project_one', note_id='note_one', note=note)

    api_response = api_instance.list_notes('project_one')

    pprint(api_response)

except ApiException as e:
    print("Exception when calling GrafeasApi-> : %s\n" % e)
