#!/usr/bin/python3
import psycopg2, cgi
import login


form = cgi.FieldStorage()

gpslat = form.getvalue('gpslat')
gpslong = form.getvalue('gpslong')
sname = form.getvalue('sname')
saddress = form.getvalue('saddress')



print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Update Supervisor</title>')
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
    print('<h1> Update Supervisor </h1>')

    # Updating the supervisor
    sql_update_supervisor = "UPDATE substation SET sname = %(sname)s, saddress = %(saddress)s WHERE gpslat=%(gpslat)s AND gpslong=%(gpslong)s;"

    # Execute
    cursor.execute(sql_update_supervisor, {'sname': sname, 'saddress': saddress, 'gpslat': gpslat, 'gpslong': gpslong})

    connection.commit()

    #Display success message and return to home button
    print('<h3>Your supervisor was updated successfully</h3>')
    print('<a href="list_substation.cgi">Return home</a>')

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