# Google Calendar Integration with Ballerina

1. Follow the instructions in this [guide](https://medium.com/@nuvidu-18/manage-work-schedules-with-ballerina-a-guide-to-google-calendar-apis-2820755bc4b1) to obtain the necessary credentials.

2. Add the obtained credentials into the `Config.toml` file in your Ballerina project.

    ```toml
    clientId = "client-id"
    clientSecret = "client-secret"
    refreshToken = "refresh-token"
    email = "email-address-of-the-user"

    gmailClientId = "client-id-of-the-invitee"
    gmailClientSecret = "client-secret-of-the-invitee"
    gmailRefreshToken = "refresh-token-of-the-invitee"
    attendees = [] # Add the email addresses of the attendees here
    ```

3. If you are new to Ballerina, download and install the latest version from [here](https://ballerina.io/downloads/).

4. Run the ballerina application

    ```ballerina
    bal run
    ```
