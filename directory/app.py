import mysql.connector
from flask import Flask

app = Flask(__name__)

# Database configuration
config = {
  'user': 'root',
  'password': 'Mysql123*',
  'host': '127.0.0.1',
  'database': 'project',
  'raise_on_warnings': True
}

# Connect to the database
cnx = mysql.connector.connect(**config)

@app.route('/')
def hello_world():
    # Use the connection
    cursor = cnx.cursor()
    cursor.execute("SELECT * FROM Customer")
    data = cursor.fetchall()
    cursor.close()
    return str(data)

@app.route('/devices')
def devices():
    cursor = cnx.cursor()
    cursor.execute("SELECT * FROM Device")
    data = cursor.fetchall()
    cursor.close()
    return str(data)

if __name__ == '__main__':
    app.run(debug=True)

