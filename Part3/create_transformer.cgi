#!/usr/bin/python3
import psycopg2, cgi
import login


form = cgi.FieldStorage()

id = form.getvalue('id')
pv = form.getvalue('pv')
sv = form.getvalue('sv')
gpslat = form.getvalue('gpslat')
gpslong = form.getvalue('gpslong')
pbbid = form.getvalue('pbbid')
sbbid = form.getvalue('sbbid')


print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Transformer Created</title>')
print('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">')
print('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    print('<h1> Transformer Creation </h1>')

    # Creating an element
    sql_create_element = "INSERT INTO element VALUES( %(id)s );"
    ## Creating a busbar
    sql_create_transformer = "INSERT INTO transformer VALUES(%(id)s, %(pv)s, %(sv)s, %(gpslat)s, %(gpslong)s, %(pbbid)s, %(sbbid)s);"

    # Execute
    cursor.execute(sql_create_element, {'id': id})
    cursor.execute(sql_create_transformer, {'id': id, 'pv': pv, 'sv': sv, 'gpslat': gpslat, 'gpslong': gpslong, 'pbbid': pbbid, 'sbbid': sbbid})

    connection.commit()

    #Display success message and return to home button
    print('<h3>Your Transformer was created successfully</h3>')
    print('<a href="list_transformer.cgi">Return home</a>')

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