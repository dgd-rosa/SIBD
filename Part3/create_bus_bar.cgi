#!/usr/bin/python3
import psycopg2, cgi
import login


form = cgi.FieldStorage()

id = form.getvalue('id')
voltage = form.getvalue('voltage')


print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Bus Bar Created</title>')
print('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    print('<h1> Bus Bar Creation </h1>')

    # Creating an element
    sql_create_element = "INSERT INTO element VALUES(%(id)s);"
    ## Creating a busbar
    sql_create_busbar = "INSERT INTO busbar VALUES(%(id)s, %(voltage)s);"

    # Execute
    cursor.execute(sql_create_element, {'id': id})
    cursor.execute(sql_create_busbar, {'id': id, 'voltage': voltage})

    connection.commit()

    #Display success message and return to home button
    print('<h3>Your Bus Bar was created successfully</h3>')
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