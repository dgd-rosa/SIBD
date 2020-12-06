#!/usr/bin/python3
import psycopg2
import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Transformer Insertion</title>')
print('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    print('<h1> Transformer Insertion </h1>')

   # The form will send the info needed for the SQL query
    print('<form action="create_transformer.cgi" method="post">')
    print('<p>Id: <input type="text" name="id" required/></p>')
    print('<p>pv: <input type="number" name="pv"/></p>')
    print('<p>sv: <input type="number" name="sv"/></p>')
    print('<p>gpslat: <input type="number" name="gpslat" /></p>')
    print('<p>gpslong: <input type="number" name="gpslong" /></p>')
    print('<p>pbbid: <input type="text" name="pbbid"/></p>')
    print('<p>sbbid: <input type="text" name="sbbid"/></p>')
    print('<p><input type="submit" value="Submit"/></p>')
    print('</form>')

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