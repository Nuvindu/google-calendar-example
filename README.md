# Google Calendar Integration with Ballerina

1. Follow the instructions in this [guide](https://medium.com/@nuvidu-18/manage-work-schedules-with-ballerina-a-guide-to-google-calendar-apis-2820755bc4b1) to obtain the necessary credentials.

2. Add the obtained credentials into the `Config.toml` file in your Ballerina project.

    ```bash
    clientId = "put-the-client-id-here"
    clientSecret = "put-the-client-secret-here"
    refreshToken = "put-the-refresh-token-here"
    refreshUrl = "https://oauth2.googleapis.com/token"
    ```

3. If you are new to Ballerina, download and install the latest version from [here](https://ballerina.io/downloads/).

4. Run the ballerina application

    ```ballerina
    bal run
    ```
