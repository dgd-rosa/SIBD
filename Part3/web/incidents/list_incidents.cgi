#!/usr/bin/python3
import psycopg2
#The following imports are needed for a foldered strcutre

import sys
sys.path.insert(1, '/afs/.ist.utl.pt/users/0/5/ist190105/web/sibd')

import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Incidents List</title>')
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
    print('<h1> Incidents for non-line elements List </h1>')

    # Making query
    sql = 'SELECT * FROM incident WHERE id NOT IN (SELECT id FROM line);'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)

    # Displaying results
    print('<p> ' + str(num) + ' records retrieved:</p>')
    print('<table class="table table-striped table-borderless table-hover">')
    print('<thead class="thead-dark">')
    print('<tr><th scope="col">instant</th><th scope="col">id</th><th scope="col">description</th><th scope="col">severity</th><th scope="col"></th></tr>')
    print('</thead>')
    print('<tbody>')
    for row in result:
        print('<tr scope="row">')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>')
            print(value)
            print('</td>')
        

        
        print('<td>')
        print('<a href="edit_incident.cgi?instant=')
        print(row[0])
        print('&id=')
        print(row[1])
        print('&description=')
        print(row[2])
        print('">')
        print('<i class="fa fa-pencil"></i>')
        print('</a>')
        print('</td>')
        
        print('</tr>')


    print('</tbody>')
    print('</table>')

    #Insert button
    print('<a href="insert_incident.cgi" >')
    print('<i class="fa fa-plus fa-4x"></i>')
    print('</a>')

    print('</div>')

    #Closing connection
    cursor.close()
except Exception as e:
    print('<h1>An error occurred.</h1>')
    
finally:
    if connection is not None:
        connection.close()


print('<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>')
print('<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>')
print('</body>')
print('</html>')