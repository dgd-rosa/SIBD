#!/usr/bin/python3
import psycopg2
import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Substation List</title>')
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
    print('<h1> Substation List </h1>')

    # Making query
    sql = 'SELECT * FROM substation;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)

    # Displaying results
    print('<p> ' + str(num) + ' records retrieved:</p>')
    print('<table class="table table-striped table-borderless table-hover">')
    print('<thead class="thead-dark">')
    print('<tr><th scope="col">gpslat</th><th scope="col">gpslong</th><th scope="col">locality</th><th scope="col">sname</th><th scope="col">saddress</th><th scope="col"></th><th scope="col"></th></tr>')
    print('</thead>')
    print('<tbody>')
    for row in result:
        print('<tr scope="row">')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>')
            print(value)
            print('</td>')

        #Remove button        
        print('<td>')
        print('<a href="delete_substation.cgi?gpslat=')
        print(row[0])
        print('&gpslong=')
        print(row[1])
        print('">')
        print('<i class="fa fa-minus"></i>')
        print('</a>')
        print('</td>')

        #Edit button
        print('<td>')
        print('<a href="edit_supervisor.cgi?gpslat=')
        print(row[0])
        print('&gpslong=')
        print(row[1])
        print('&sname=')
        print(row[3])
        print('&saddress=')
        print(row[4])
        print('">')
        print('<i class="fa fa-pencil"></i>')
        print('</a>')
        print('</td>')
        

        print('</tr>')
    print('</tbody>')
    print('</table>')

    #Insert button
    print('<a href="insert_substation.cgi" >')
    print('<i class="fa fa-plus fa-4x"></i>')
    print('</a>')

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