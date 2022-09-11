import pymysql


connection = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    db='mydb',
    charset='utf8mb4',
    cursorclass=pymysql.cursors.DictCursor
)

cursor = connection.cursor()
cursor.close()
connection.close()