import ballerinax/googleapis.gcalendar;
import ballerina/io;

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
    gcalendar:Client calendar = check new(config);

    // create a calendar
    gcalendar:Calendar calendarResult = check calendar->/calendars.post({
        summary: "Work Schedule"
    });

    io:println("Calendar ID: ", calendarResult);
    string calendarId = <string>calendarResult.id;

    // create an event
    gcalendar:Event sprintEvent = check calendar->/calendars/[calendarId]/events.post(
        payload =
            {
                'start: {
                    dateTime: "2024-02-22T10:00:00+00:00",
                    timeZone: "UTC"
                },
                end: {
                    dateTime: "2024-02-22T12:00:00+00:00",
                    timeZone: "UTC"
                },
                summary: "Sprint Meeting",
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

    io:println("Event ID: ", sprintEvent);
}
