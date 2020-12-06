#!/usr/bin/python3
import psycopg2
import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Transformer List</title>')
print('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    print('<h1> Transformer List </h1>')

    # Making query
    sql = 'SELECT * FROM transformer;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)

    # Displaying results
    print('<p> ' + str(num) + ' records retrieved:</p>')
    print('<table border="5">')
    print('''<tr>
            <th>id</th>
            <th>pv</th>
            <th>sv</th>
            <th>gpslat</th>
            <th>gpslong</th>
            <th>pbbid</th>
            <th>sbbid</th>
        </tr>''')
    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>')
            print(value)
            print('</td>')
        
        print('<td>')
        print('<a href="delete_transformer.cgi?id=' + row[0] + '">')
        print('<i class="fa fa-minus"></i>')
        print('</a>')
        print('</td>')
        
        print('</tr>')
    print('</table>')

    #Insert button
    print('<a href="insert_transformer.cgi" >')
    print('<i class="fa fa-plus fa-4x"></i>')
    print('</a>')

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