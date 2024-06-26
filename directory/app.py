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

@app.route('/locations', methods=['GET'])
def get_all_locations():
    try:
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM ServiceLocation")
        locations = cursor.fetchall()
        cursor.close()

        return jsonify({'locations': locations}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/eventdatas', methods=['GET'])
def get_all_eventdatas():
    try:

        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM EventData")
        eventdata = cursor.fetchall()
        cursor.close()

        return jsonify({'eventdata': eventdata}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/eventdata/<device_id>', methods=['GET'])
def get_all_eventdata(device_id):
    try:

        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM EventData WHERE EventType = 'energy use' AND DeviceID = %s", (device_id, ))
        eventdata = cursor.fetchall()
        cursor.close()

        return jsonify({'eventdata': eventdata}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/eventdata/monthly/<location_id>', methods=['GET'])
def get_all_eventdata_location_monthly(location_id):
    try:

        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
            SELECT 
                d.LocationID,
                MONTH(ed.Timestamp) AS Month,
                YEAR(ed.Timestamp) AS Year,
                SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) ELSE 0 END) AS TotalEnergyUsage
            FROM 
                EventData ed
            JOIN 
                Device d ON ed.DeviceID = d.DeviceID
            WHERE 
                d.LocationID = %s
                AND ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-09-30 23:59:59'
                AND ed.EventType = 'energy use'
            GROUP BY 
                d.LocationID, MONTH(ed.Timestamp), YEAR(ed.Timestamp)
        """, (location_id,))
        eventdatalocation_monthly = cursor.fetchall()
        cursor.close()

        return jsonify({'eventdata': eventdatalocation_monthly}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/eventdata/daily/<location_id>', methods=['GET'])
def get_all_eventdata_location_daily(location_id):
    try:

        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
            SELECT 
    DATE(ed.Timestamp) AS Date,
    sl.LocationID,
    SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) ELSE 0 END) AS DailyEnergyUsage
FROM 
    ServiceLocation sl
JOIN 
    Device d ON sl.LocationID = d.LocationID
JOIN 
    EventData ed ON d.DeviceID = ed.DeviceID
WHERE 
    sl.LocationID = %s AND
    ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-09-30 23:59:59' AND
    ed.EventType = 'energy use'
GROUP BY 
    DATE(ed.Timestamp), sl.LocationID
ORDER BY 
    Date
        """, (location_id,))
        eventdatalocation_daily = cursor.fetchall()
        cursor.close()

        return jsonify({'eventdata': eventdatalocation_daily}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/eventdata/location_wise/<customer_id>', methods=['GET'])
def get_all_eventdata_location_wise(customer_id):
    try:

        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
    SELECT
    c.CustomerID,
    c.Name,
    sl.LocationID,
    sl.Address,
    SUM(CASE WHEN ed.EventType = 'energy use' THEN
    CAST(ed.Value AS DECIMAL(10,2)) * ep.PricePerKWh ELSE 0
    END) AS TotalEnergyCost
FROM
    Customer c
JOIN
    ServiceLocation sl ON c.CustomerID = sl.CustomerID
JOIN
    Device d ON sl.LocationID = d.LocationID
JOIN
    EventData ed ON d.DeviceID = ed.DeviceID
LEFT OUTER JOIN
    EnergyPrice ep ON sl.ZipCode = ep.ZipCode
    AND
    ep.Time = (
    SELECT
        MAX(Time)
    FROM
        EnergyPrice
    WHERE
        ZipCode = sl.ZipCode
        AND
        Time <= TIME(ed.Timestamp)
    )
WHERE
    ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
    AND
    ed.EventType = 'energy use'
    AND
    c.CustomerID = %s
GROUP BY
    c.CustomerID,
    c.Name,
    sl.LocationID,
    sl.Address;
                       """, (customer_id,))
        eventdatalocation_wise = cursor.fetchall()
        cursor.close()

        return jsonify({'eventdata': eventdatalocation_wise}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500    

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
        AND Status = 'ACTIVE'
        """, (customer_id,))
        locations = cursor.fetchall()
        mysqlx.commit()
        cursor.close()

        return jsonify({'locations': locations}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/location/<location_id>', methods=['DELETE'])
def delete_location(location_id):
    try:
        print(location_id)
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
        UPDATE Device
        SET Status = 'Not Active'
        WHERE LocationID = %s
        """, (location_id,))
        mysqlx.commit()
        cursor.close()

        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
        UPDATE ServiceLocation
        SET Status = 'Not Active'
        WHERE LocationID = %s
        """, (location_id,))
        mysqlx.commit()
        cursor.close()

        return jsonify({'message': 'Location deleted'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
# @app.route('/location/<location_id>', methods=['GET'])
# def get_location_data(location_id):
#     try:
#         print(location_id)
#         cursor = mysqlx.cursor(dictionary=True)
#         cursor.execute("""
#         SELECT * FROM ServiceLocation
#         WHERE LocationID = %s
#         """, (location_id,))
#         location = cursor.fetchone()
#         mysqlx.commit()
#         cursor.close()
#         return jsonify({'message': location}), 200
        
#     except Exception as e:
#         return jsonify({'error': str(e)}), 500
    
@app.route('/delete_device/<device_id>', methods=['DELETE'])
def delete_device(device_id):
    try:
        print(device_id)
        cursor = mysqlx.cursor(dictionary=True)
        cursor.execute("""
        UPDATE Device
        SET Status = 'Not Active'
        WHERE DeviceID = %s
        """, (device_id,))
        mysqlx.commit()
        cursor.close()

        return jsonify({'message': 'Device deleted'}), 200
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

