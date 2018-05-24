import requests
import json
import random
import string
import hvac
import os

client = hvac.Client(url='https://127.0.0.01:8200', token=os.environ['VAULTTOKEN'], verify=False)

secretResponse  = client.create_role_secret_id(role_name='testapi')

secretid = secretResponse['data']['secret_id']

roleid = os.environ['ROLEID']

authResponse = client.auth_approle(role_id=roleid,secret_id=secretid)

accToken = authResponse['auth']['client_token']

secretDB = client.read(path='secret/testapi')

apiAccessKey = secretDB['data']['key']

print(client.is_initialized())


url = "https://3auvqg06yk.execute-api.ap-southeast-1.amazonaws.com/test/student"

randomString = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8))


data = {'name': 'student-demo-'+randomString,
        'description':'description-'+randomString}

dataJSON = json.dumps(data).encode('utf8')

httpheaders = {'x-api-key':apiAccessKey}

r = requests.post(url=url, data = dataJSON, headers = httpheaders)

print(r.text)
