#!/usr/bin/python3
import psycopg2, cgi
#The following imports are needed for a foldered strcutre

import sys
sys.path.insert(1, '/afs/.ist.utl.pt/users/0/5/ist190105/web')

import login


form = cgi.FieldStorage()

id = form.getvalue('id')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Bus Bar Deletion</title>')
print('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    print('<h1> Bus Bar Deletion </h1>')

    #Delete corresponding analyses
    sql_delete_analyses = "DELETE FROM analyses WHERE id=%(id)s;"
    #Delete corresponding incidents
    sql_delete_incident = "DELETE FROM incident WHERE id=%(id)s;"
    #Delete corresponding transformers
    sql_delete_transformer = "DELETE FROM transformer WHERE pbbid=%(id)s OR sbbid=%(id)s;"
    #Delete corresponding lines
    sql_delete_line = "DELETE FROM line WHERE pbbid=%(id)s OR sbbid=%(id)s;"
    #Deleting an element
    sql_delete_element = "DELETE FROM element WHERE id=%(id)s;"
    #Deleting a busbar
    sql_delete_busbar = "DELETE FROM busbar WHERE id=%(id)s;"

    #Execute
    cursor.execute(sql_delete_analyses, {'id': id})
    cursor.execute(sql_delete_incident, {'id': id})
    cursor.execute(sql_delete_transformer, {'id': id})
    cursor.execute(sql_delete_line, {'id': id})
    cursor.execute(sql_delete_busbar, {'id': id})
    cursor.execute(sql_delete_element, {'id': id})

    connection.commit()


    #Display success message and return to home button
    print('<h3>Your Bus Bar was deleted successfully</h3>')
    print('<a href="list_bus_bar.cgi">Return home</a>')

    #Closing connection
    cursor.close()
except Exception as e:
    print('<h1>An error occurred.</h1>')
    print('<p>' + str(e) + '</p>')
finally:
    if connection is not None:
        connection.close()

print('</body>')
print('</html>')