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

        cursor = mysqlx.cursor()
        cursor.execute("INSERT INTO Customer (Name, username, BillingAddress) VALUES (%s, %s, %s)", (name, username, address))
        mysqlx.commit()
        cursor.close()

        cursor = mysqlx.cursor()
        cursor.execute("SELECT CustomerID FROM Customer WHERE username = %s", (username,))
        customer_id = cursor.fetchone()[0]
        cursor.close()

        return jsonify({'message': 'Registration successful', 'customer_id': customer_id}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/signin', methods=['POST'])
def signin():
    try:
        data = request.json
        username = data['username']
        password = data['password']

        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Accounts WHERE username = %s AND password = %s", (username, password))
        user = cursor.fetchone()
        cursor.close()

        cursor = mysqlx.cursor()
        cursor.execute("SELECT CustomerID FROM Customer WHERE username = %s", (username,))
        customer_id = cursor.fetchone()[0]
        cursor.close()

        if user:
            # Authentication successful
            return jsonify({'message': 'Registration successful', 'customer_id': customer_id}), 200
        else:
            # Authentication failed
            return jsonify({'message': 'Authentication failed. Invalid username or password'}), 401

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
# API endpoint for the /dashboard route
@app.route('/dashboard/<customer_id>', methods=['GET'])
def dashboard(customer_id):
    try:
        # Fetch customer details from the database based on customer_id
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Customer WHERE CustomerID = %s", (customer_id,))
        customer_data = cursor.fetchone()
        cursor.close()

        if customer_data:
            return jsonify(customer_data)
        else:
            return jsonify({'error': 'Customer not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
# API endpoint for the /newlocation route    
@app.route('/newlocation', methods=['POST'])
def save_location():
    try:
        data = request.get_json()
        customer_id = data['customerID']
        address = data['address']
        zipcode = data['zipcode']
        unit = data['unit']
        takedate = data['takedate']
        sq = data['sq']
        beds = data['beds']
        occupants = data['occupants']
        # Extract other fields as needed

        # Perform MySQL database insertion
        # (Assuming you have a MySQL connection named 'db')
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
        INSERT INTO ServiceLocation (CustomerID, Address, ZipCode, UnitNumber, TakeoverDate, SquareFootage, Bedrooms, Occupants)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """, (customer_id, address, zipcode, unit, takedate, sq, beds, occupants))
        mysqlx.commit()
        cursor.close()

        return jsonify({'message': 'Location saved successfully'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/locations/<customer_id>', methods=['GET'])
def locations(customer_id):
    try:
        print(customer_id)
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
        SELECT * FROM ServiceLocation
        WHERE CustomerID = %s
        """, (customer_id,))
        locations = cursor.fetchall()
        mysqlx.commit()
        cursor.close()

        return jsonify({'locations': locations}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/devices/<customer_id>/<location_id>', methods=['GET'])
def devices(customer_id, location_id):
    try:
        print(customer_id, location_id)
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
        SELECT * FROM Device
        WHERE LocationID = %s
        """, (location_id, ))
        devices = cursor.fetchall()
        mysqlx.commit()
        cursor.close()

        print(devices)
        return jsonify({'devices': devices}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/add_device/<location_id>', methods=['POST'])
def add_device(location_id):
    try:
        
        cursor = mysqlx.cursor(dictionary=True)
        device_data = request.get_json()

        cursor.execute("""
            INSERT INTO Device (LocationID, Type, ModelNumber)
            VALUES (%s, %s, %s)
        """, (location_id, device_data['type'], device_data['model']))
        mysqlx.commit()
        cursor.close()
        mysqlx.close()

        return jsonify({'message': 'Device added successfully'}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

