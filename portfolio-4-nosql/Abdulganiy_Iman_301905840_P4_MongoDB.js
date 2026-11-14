// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("engagement_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("engagement_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "engagement_created",
                    "consultant_assigned"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "work_log"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "work_log_id"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("engagement_events").insertMany([
    {
        "_id": "event_000001",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "engagement_created",
        "occurredAt": ISODate("2030-01-01T10:00:00Z"),
        "source": {
            "entity": "work_log",
            "key": {
                "work_log_id": 401
            },
            "snapshot": {
                "work_log_id": 401,
                "engagement_id": 301,
                "consultant_id": 201,
                "work_date": "2026-03-02",
                "hours": 3.5,
                "billable": true,
                "notes": "Synthetic planning interview"
            }
        },
        "embedded": {
            "consultant": [
                {
                    "key": {
                        "consultant_id": 201
                    },
                    "snapshot": {
                        "consultant_id": 201,
                        "full_name": "Avery Morgan",
                        "specialty": "Workforce Planning",
                        "hourly_rate": 145
                    },
                    "via": [
                        "work_log.consultant_id → consultant"
                    ]
                }
            ]
        },
        "references": {
            "engagement": [
                {
                    "key": {
                        "engagement_id": 301
                    },
                    "via": [
                        "work_log.engagement_id → engagement"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "consultant_assigned",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
        "source": {
            "entity": "work_log",
            "key": {
                "work_log_id": 401
            },
            "snapshot": {
                "work_log_id": 401,
                "engagement_id": 301,
                "consultant_id": 201,
                "work_date": "2026-03-02",
                "hours": 3.5,
                "billable": true,
                "notes": "Synthetic planning interview"
            }
        },
        "embedded": {
            "consultant": [
                {
                    "key": {
                        "consultant_id": 201
                    },
                    "snapshot": {
                        "consultant_id": 201,
                        "full_name": "Avery Morgan",
                        "specialty": "Workforce Planning",
                        "hourly_rate": 145
                    },
                    "via": [
                        "work_log.consultant_id → consultant"
                    ]
                }
            ]
        },
        "references": {
            "engagement": [
                {
                    "key": {
                        "engagement_id": 301
                    },
                    "via": [
                        "work_log.engagement_id → engagement"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "change_payload": "illustrative change_payload",
                "tags": "illustrative tags"
            }
        }
    },
    {
        "_id": "event_000003",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "engagement_created",
        "occurredAt": ISODate("2030-01-01T10:02:00Z"),
        "source": {
            "entity": "work_log",
            "key": {
                "work_log_id": 402
            },
            "snapshot": {
                "work_log_id": 402,
                "engagement_id": 302,
                "consultant_id": 202,
                "work_date": "2026-04-02",
                "hours": 2,
                "billable": false,
                "notes": null
            }
        },
        "embedded": {
            "consultant": [
                {
                    "key": {
                        "consultant_id": 202
                    },
                    "snapshot": {
                        "consultant_id": 202,
                        "full_name": "Jordan Lee",
                        "specialty": "Employee Relations",
                        "hourly_rate": 160
                    },
                    "via": [
                        "work_log.consultant_id → consultant"
                    ]
                }
            ]
        },
        "references": {
            "engagement": [
                {
                    "key": {
                        "engagement_id": 302
                    },
                    "via": [
                        "work_log.engagement_id → engagement"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000004",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "consultant_assigned",
        "occurredAt": ISODate("2030-01-01T10:03:00Z"),
        "source": {
            "entity": "work_log",
            "key": {
                "work_log_id": 402
            },
            "snapshot": {
                "work_log_id": 402,
                "engagement_id": 302,
                "consultant_id": 202,
                "work_date": "2026-04-02",
                "hours": 2,
                "billable": false,
                "notes": null
            }
        },
        "embedded": {
            "consultant": [
                {
                    "key": {
                        "consultant_id": 202
                    },
                    "snapshot": {
                        "consultant_id": 202,
                        "full_name": "Jordan Lee",
                        "specialty": "Employee Relations",
                        "hourly_rate": 160
                    },
                    "via": [
                        "work_log.consultant_id → consultant"
                    ]
                }
            ]
        },
        "references": {
            "engagement": [
                {
                    "key": {
                        "engagement_id": 302
                    },
                    "via": [
                        "work_log.engagement_id → engagement"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "change_payload": "illustrative change_payload",
                "tags": "illustrative tags"
            }
        }
    }
]));
  await db.getCollection("engagement_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("engagement_events").find({"eventType":"engagement_created"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("engagement_events").find({"source.key.work_log_id":401}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("engagement_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("engagement_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("engagement_events").insertOne({...{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "engagement_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "work_log",
        "key": {
            "work_log_id": 401
        },
        "snapshot": {
            "work_log_id": 401,
            "engagement_id": 301,
            "consultant_id": 201,
            "work_date": "2026-03-02",
            "hours": 3.5,
            "billable": true,
            "notes": "Synthetic planning interview"
        }
    },
    "embedded": {
        "consultant": [
            {
                "key": {
                    "consultant_id": 201
                },
                "snapshot": {
                    "consultant_id": 201,
                    "full_name": "Avery Morgan",
                    "specialty": "Workforce Planning",
                    "hourly_rate": 145
                },
                "via": [
                    "work_log.consultant_id → consultant"
                ]
            }
        ]
    },
    "references": {
        "engagement": [
            {
                "key": {
                    "engagement_id": 301
                },
                "via": [
                    "work_log.engagement_id → engagement"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("engagement_events").insertOne({
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "engagement_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "work_log",
        "key": {
            "work_log_id": 401
        },
        "snapshot": {
            "work_log_id": 401,
            "engagement_id": 301,
            "consultant_id": 201,
            "work_date": "2026-03-02",
            "hours": 3.5,
            "billable": true,
            "notes": "Synthetic planning interview"
        }
    },
    "embedded": {
        "consultant": [
            {
                "key": {
                    "consultant_id": 201
                },
                "snapshot": {
                    "consultant_id": 201,
                    "full_name": "Avery Morgan",
                    "specialty": "Workforce Planning",
                    "hourly_rate": 145
                },
                "via": [
                    "work_log.consultant_id → consultant"
                ]
            }
        ]
    },
    "references": {
        "engagement": [
            {
                "key": {
                    "engagement_id": 301
                },
                "via": [
                    "work_log.engagement_id → engagement"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("engagement_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });
