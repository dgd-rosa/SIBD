#!/usr/bin/python3
import psycopg2, cgi
#The following imports are needed for a foldered strcutre

import sys
sys.path.insert(1, '/afs/.ist.utl.pt/users/0/5/ist190105/web')

import login
from decimal import Decimal



form = cgi.FieldStorage()

id = form.getvalue('id')
pbbid_pv = form.getvalue('pbbid_pv')
sbbid_sv = form.getvalue('sbbid_sv')
gps = form.getvalue('gps')

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
    print('<div class="container">')
    print('<h1> Transformer Creation </h1>')

    pbbid, pv = pbbid_pv.split(" &&& ")
    sbbid, sv = sbbid_sv.split(" &&& ")
    gpslat, gpslong = gps.split(" &&& ")

    pv = Decimal(pv)
    sv = Decimal(sv)
    gpslat = Decimal(gpslat)
    gpslong = Decimal(gpslong)

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