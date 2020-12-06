#!/usr/bin/python3
import psycopg2
#The following imports are needed for a foldered strcutre

import sys
sys.path.insert(1, '/afs/.ist.utl.pt/users/0/5/ist190105/web')

import login


print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Inciden Insertion</title>')
print('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">')
print('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    print('<div class="container">')
    print('<h1> Incident Insertion </h1>')

   # The form will send the info needed for the SQL query
    print('<form action="create_incident.cgi" method="post">')
    print('<p>instant: <input class="form-control" type="text" name="instant" placeholder="Enter Time" /></p>')
    print('<p>id: <input class="form-control" type="text" name="id" placeholder="Enter Element ID" /></p>')
    print('<p>description: <input class="form-control" type="text" name="description" placeholder="Incident Description"/></p>')
    print('<p>severity: <input class="form-control" type="text" name="severity" placeholder="Low, Medium, High"/></p>')
    print('<p><input class="btn btn-primary" type="submit" value="Submit"/></p>')
    print('</form>')

    print('</div>')

    #Closing connection
    cursor.close()
except Exception as e:
    print('<h1>An error occurred.</h1>')
    print('<p>' + str(e) + '</p>')
finally:
    if connection is not None:
        connection.close()

print('<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>')
print('<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>')
print('</body>')
print('</html>')