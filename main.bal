import ballerina/io;
import ballerinax/googleapis.gcalendar;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;

gcalendar:ConnectionConfig config = {
    auth: {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshToken: refreshToken,
        refreshUrl: refreshUrl
    }
};

public function main() returns error? {
    gcalendar:Client calendar = check new (config);

    // create a calendar
    gcalendar:Calendar calendarResult = check calendar->/calendars.post({
        summary: "Work Schedule"
    });

    string calendarId = <string>calendarResult.id;

    // create an event
    gcalendar:Event event = check calendar->/calendars/[calendarId]/events.post(
        payload =
            {
            'start: {
                dateTime: "2024-02-22T10:00:00+00:00",
                timeZone: "UTC"
            },
            end: {
                dateTime: "2024-02-22T11:00:00+00:00",
                timeZone: "UTC"
            },
            summary: "Project Progress Meeting",
            conferenceData: {
                createRequest: {
                    requestId: "sofhoi4oin",
                    conferenceSolutionKey: {
                        'type: "hangoutsMeet"
                    }
                }
            }
        },
        conferenceDataVersion = 1
    );

    string eventId = <string>event.id;

    gcalendar:Event|gcalendar:Error updatedEvent = calendar->/calendars/[calendarId]/events/[eventId].put({
        'start: {
            dateTime: "2024-02-22T10:00:00+00:00",
            timeZone: "UTC"
        },
        end: {
            dateTime: "2024-02-22T11:00:00+00:00",
            timeZone: "UTC"
        },
        summary: "Project Progress Meeting - Team A",
        attendees: [
            {
                "email": "team-member1@gmail.com"
            },
            {
                "email": "team-member2@gmail.com"
            }
        ]
    });
    io:println("Updated Event: ", updatedEvent);

    gcalendar:Event|error reminderEvent = calendar->/calendars/[calendarId]/events/[eventId].put({
        'start: {
            dateTime: "2024-02-22T10:00:00+00:00",
            timeZone: "UTC"
        },
        end: {
            dateTime: "2024-02-22T11:00:00+00:00",
            timeZone: "UTC"
        },
        summary: "Project Progress Meeting - Team A",
        attendees: [
            {
                "email": "team-member1@gmail.com"
            },
            {
                "email": "team-member2@gmail.com"
            }
        ],
        reminders: {
            useDefault: false,
            overrides: [
                {
                    method: "popup",
                    minutes: 15
                },
                {
                    method: "email",
                    minutes: 30
                }
            ]
        }
    });
    io:println("Reminder Event: ", reminderEvent);
}
