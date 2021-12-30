from flask import Flask, render_template, request, redirect, url_for, session
import sqlite3
import MySQLdb.cursors
import re
import logging
  
app = Flask(__name__)
  
  
app.secret_key = 'secret'
  
@app.route('/')
def home():
    msg = ''
    if session:
        if session['username'] == 'administrator' and session['loggedin'] == True:
            con = sqlite3.connect("flask.db")
            cursor = con.cursor()
            cursor.execute('SELECT flag FROM flag')
            flag = cursor.fetchone()
            msg = flag[0]
            con.close()
            return render_template('index.html', msg = msg)
        elif session['username'] and session['loggedin'] == True:
            msg = "Sorry, no flag for you :("
            return render_template('index.html', msg = msg)
    else:
        return render_template('login.html', msg = msg)

@app.route('/login', methods =['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        con = sqlite3.connect("flask.db")
        cursor = con.cursor()
        cursor.execute('SELECT * FROM users WHERE username = ? AND password = ?', (username, password))
        account = cursor.fetchone()
        con.close()
        if account:
            print (account)
            session['loggedin'] = True
            session['username'] = account[1]
            msg = 'Logged in successfully !'
            return redirect(url_for('home'))
        else:
            msg = 'Incorrect username / password !'
    return render_template('login.html', msg = msg)
  
@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('username', None)
    return redirect(url_for('login'))
  
@app.route('/register', methods =['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form :
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        con = sqlite3.connect('flask.db')
        cursor = con.cursor()
        cursor.execute('SELECT * FROM users WHERE username = ?', (username, ))
        account = cursor.fetchone()
        if account:
            msg = 'Account already exists !'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address !'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers !'
        elif not username or not password or not email:
            msg = 'Please fill out the form !'
        else:
            cursor.execute('INSERT INTO users VALUES (NULL, ?, ?, ?)', (username, password, email, ))
            con.commit()
            msg = 'You have successfully registered !'
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('register.html', msg = msg)


log = logging.getLogger('werkzeug')
log.disabled = True

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=2222, debug=False)
