#!/usr/bin/python3
import psycopg2
#The following imports are needed for a foldered strcutre

import sys
sys.path.insert(1, '/afs/.ist.utl.pt/users/0/5/ist190105/web')

import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Transformer Insertion</title>')
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
    print('<h1> Transformer Insertion </h1>')

    sql = 'SELECT * FROM busbar;'
    cursor.execute(sql)
    result_bb = cursor.fetchall()

    sql = 'SELECT * FROM substation;'
    cursor.execute(sql)
    result_s = cursor.fetchall()


   # The form will send the info needed for the SQL query
    print('<form action="create_transformer.cgi" method="post">')
    print('<p>Id: <input class="form-control" type="text" name="id" required/></p>')

    print('<div>')
    print('<select class="form-control" name="gps" id="drop0" required>')
    print('<option value="" selected disabled hidden>Select substation</option>')
    for row in result_s:
        print('<option value="' + str(row[0]) + ' &&& ' + str(row[1]) + '"> gpslat: ' + str(row[0]) + ' gpslong: ' + str(row[1]) + '</option>')
    print('</select>')
    print('</div>')

    print('<br>')
    
    
    print('<div>')
    print('<select class="form-control" name="pbbid_pv" id="drop1" required>')
    print('<option value="" selected disabled hidden>Select primary busbar</option>')
    for row in result_bb:
        print('<option value="' + row[0] + ' &&& ' + str(row[1]) + '"> id: ' + row[0] + ' voltage: ' + str(row[1]) + '</option>')
    print('</select>')
    print('</div>')

    print('<br>')

    print('<div>')
    print('<select class="form-control" name="sbbid_sv" id="drop2" required>')
    print('<option value="" selected disabled hidden>Select secondary busbar</option>')
    for row in result_bb:
        print('<option value="' + row[0] + ' &&& ' + str(row[1]) + '"> id: ' + row[0] + ' voltage: ' + str(row[1]) + '</option>')
    print('</select>')
    print('</div>')

    print('<br>')


    print('<p><input class="btn btn-primary" type="submit" value="Submit"/></p>')
    print('</form>')

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