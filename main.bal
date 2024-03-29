import ballerina/io;
import ballerinax/googleapis.gcalendar;
import ballerinax/googleapis.gmail;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string email = ?;

configurable string gmailClientId = ?;
configurable string gmailClientSecret = ?;
configurable string gmailRefreshToken = ?;

public function main() returns error? {
    gcalendar:Client calendar = check new ({
        auth: {
            clientId,
            clientSecret,
            refreshToken
        }
    });

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
                dateTime: "2024-03-04T10:00:00+00:00",
                timeZone: "UTC"
            },
            end: {
                dateTime: "2024-03-04T11:00:00+00:00",
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
            dateTime: "2024-03-04T10:00:00+00:00",
            timeZone: "UTC"
        },
        end: {
            dateTime: "2024-03-04T11:00:00+00:00",
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
            dateTime: "2024-03-04T10:00:00+00:00",
            timeZone: "UTC"
        },
        end: {
            dateTime: "2024-03-04T11:00:00+00:00",
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

    gmail:Client gmail = check new ({
        auth: {
            clientId: gmailClientId,
            clientSecret: gmailClientSecret,
            refreshToken: gmailRefreshToken
        }
    });

    string filter = string `from: ${email}`;
    gmail:ListMessagesResponse messageList = check gmail->/users/me/messages(q = filter);
    gmail:Message[]? messages = messageList.messages;
    if messages !is () {
        string id = messages[0].id;
        gmail:Message message = check gmail->/users/me/messages/[id].get();
        gmail:MessagePart payload = <gmail:MessagePart>message.payload;
        gmail:MessagePart[] messagePart = (<gmail:MessagePart[]>(<gmail:MessagePart[]>payload.parts)[0].parts);
        string invitation = <string>messagePart[0].data;
        io:println("Calendar Invitation: ", invitation);
    }
}
