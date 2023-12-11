import mysql.connector
from flask import Flask, request, jsonify
from flask_cors import CORS
# from flask_mysqldb import MySQL

app = Flask(__name__)
CORS(app)

# Database configuration
config = {
  'user': 'root',
  'password': 'Mysql123*',
  'host': '127.0.0.1',
  'database': 'project',
  'raise_on_warnings': True
}

# app.config['MYSQL_HOST'] = '127.0.0.1'  # Replace with your MySQL host
# app.config['MYSQL_USER'] = 'root'  # Replace with your MySQL username
# app.config['MYSQL_PASSWORD'] = 'Mysql123*'  # Replace with your MySQL password
# app.config['MYSQL_DB'] = 'project'
# mysql = MySQL(app)

# Connect to the database
mysqlx = mysql.connector.connect(**config)

# @app.route('/')
# def hello_world():
#     # Use the connection
#     cursor = cnx.cursor()
#     cursor.execute("SELECT * FROM Customer")
#     data = cursor.fetchall()
#     cursor.close()
#     return str(data)

@app.route('/', methods=['GET'])
def get_all_customers():
    try:
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Customer")
        customers = cursor.fetchall()
        cursor.close()

        return jsonify({'customers': customers}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# @app.route('/', methods=['GET'])
# def get_all_customers():
#     try:
#         cursor = mysql.connection.cursor()
#         cursor.execute("SELECT * FROM Customer")
#         customers = cursor.fetchall()
#         cursor.close()

#         return jsonify({'customers': customers}), 200

#     except Exception as e:
#         return jsonify({'error': str(e)}), 500

# @app.route('/devices')
# def devices():
#     cursor = cnx.cursor()
#     cursor.execute("SELECT * FROM Device")
#     data = cursor.fetchall()
#     cursor.close()
#     return str(data)

# API endpoint to retrieve all devices
@app.route('/devices', methods=['GET'])
def get_all_devices():
    try:
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Device")
        devices = cursor.fetchall()
        cursor.close()

        return jsonify({'devices': devices}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# @app.route('/devices', methods=['GET'])
# def get_all_devices():
#     try:
#         cursor = mysql.connection.cursor()
#         cursor.execute("SELECT * FROM Device")
#         devices = cursor.fetchall()
#         cursor.close()

#         return jsonify({'devices': devices}), 200

#     except Exception as e:
#         return jsonify({'error': str(e)}), 500

# @app.route('/accounts')
# def accounts():
#     cursor = cnx.cursor()
#     cursor.execute("SELECT * FROM Accounts")
#     data = cursor.fetchall()
#     cursor.close()
#     return str(data)

# API endpoint to retrieve all devices
@app.route('/accounts', methods=['GET'])
def get_all_accounts():
    try:
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Accounts")
        accounts = cursor.fetchall()
        cursor.close()

        return jsonify({'accounts': accounts}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# @app.route('/accounts', methods=['GET'])
# def get_all_accounts():
#     try:
#         cursor = mysql.connection.cursor()
#         cursor.execute("SELECT * FROM Accounts")
#         accounts = cursor.fetchall()
#         cursor.close()

#         return jsonify({'accounts': accounts}), 200

#     except Exception as e:
#         return jsonify({'error': str(e)}), 500

@app.route('/register', methods=['POST'])
def register():
    try:
        # Get data from the request
        data = request.json
        name = data['name']
        username = data['username']
        address = data['address']
        password = data['password']

        # Insert data into the MySQL table
        cursor = mysqlx.cursor()
        cursor.execute("INSERT INTO Accounts (username, password) VALUES (%s, %s)", (username, password))
        mysqlx.commit()
        cursor.close()

        return jsonify({'message': 'Registration successful'}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

