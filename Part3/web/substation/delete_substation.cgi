#!/usr/bin/python3
import psycopg2, cgi
#The following imports are needed for a foldered strcutre

import sys
sys.path.insert(1, '/afs/.ist.utl.pt/users/0/5/ist190105/web/sibd')

import login


form = cgi.FieldStorage()

gpslat = form.getvalue('gpslat')
gpslong = form.getvalue('gpslong')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Substation Deletion</title>')
print('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">')
print('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">')

print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    print('<h1> Substation Deletion </h1>')

    #Delete corresponding analyses
    sql_delete_substation = "DELETE FROM substation WHERE gpslat=%(gpslat)s and gpslong=%(gpslong)s ;"
    #Delete corresponding transformers
    sql_delete_transformer = "DELETE FROM transformer WHERE gpslat=%(gpslat)s and gpslong=%(gpslong)s;"

    #Execute
    cursor.execute(sql_delete_transformer, {'gpslat': gpslat, 'gpslong': gpslong})
    cursor.execute(sql_delete_substation, {'gpslat': gpslat, 'gpslong': gpslong})
    

    connection.commit()


    #Display success message and return to home button
    print('<h3>Your Substation was deleted successfully</h3>')
    print('<a href="list_substation.cgi">Return home</a>')

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