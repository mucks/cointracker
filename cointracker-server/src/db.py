import pymongo
import json
import urllib.parse
import datetime
import os
import socket

def connect():
    username = urllib.parse.quote_plus(os.getenv("COINTRACKER_USER"))
    password = urllib.parse.quote_plus(os.getenv("COINTRACKER_PASSWORD"))
    host = socket.gethostbyname('mongo')
    mongo = "mongodb://%s:%s@%s/cointracker" % (username, password, host)
    client = pymongo.MongoClient(mongo)
    return client.cointracker

def init(db):
    db.users.create_index([("username", pymongo.ASCENDING)], unique=True)



