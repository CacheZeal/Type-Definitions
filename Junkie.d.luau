--!strict

export type JD_Reason = "KEY_VALID" | "KEYLESS"
export type JD_HttpMethod = "GET" | "POST" | "PUT" | "PATCH" | "DELETE" | "HEAD" | "OPTIONS"
export type JD_NotificationKind = "Info" | "Success" | "Warning" | "Error"
export type JD_SecureRequestOptions = {
    Url: string,
    Method: JD_HttpMethod?,
    Headers: { [string]: string }?,
    Body: any?,
    Params: { [string]: any }?,
    Limits: {
        PerKey: number?,
        PerIp: number?,
    }?,
}
export type JD_SecureResponse = {
    Success: boolean,
    StatusCode: number,
    StatusMessage: string,
    Headers: { [string]: string },
    Body: string,
}
export type JD_ValidateOptions = {
    MaxLength: number,
    Pattern: string?,
}

--- Whether the authenticated access has Premium status
declare JD_IS_PREMIUM: boolean

--- "KEY_VALID" or "KEYLESS". Use this to distinguish authentication mode
declare JD_REASON: JD_Reason

--- Public token of the current script, not its numeric database ID
declare JD_SCRIPT_ID: string

--- Key creation timestamp (Unix seconds). nil when no key metadata is available
declare JD_CREATED_AT: number?

--- Key expiration timestamp (Unix seconds). nil for lifetime or keyless access
declare JD_EXPIRES_AT: number?

--- Executor device identity used for HWID binding, when available
declare JD_FINGERPRINT: string?

--- Linked Discord user ID when available
declare JD_DISCORD_ID: string?

--- Stored Discord username when available
declare JD_DISCORD_USERNAME: string?

--- Display-name alias. Currently uses the same stored name as JD_DISCORD_USERNAME
declare JD_DISCORD_DISPLAY_NAME: string?

--- Discord avatar URL when avatar metadata is available
declare JD_DISCORD_PFP: string?

--- Execution count for the current key, across scripts that use it
declare JD_EXECUTIONS: number

--- Execution count for the current script across keys
declare JD_SCRIPT_EXECUTIONS: number

--- Accumulated runtime for the current key, in seconds
declare JD_USAGE: number

--- Accumulated runtime for the current script, in seconds
declare JD_SCRIPT_USAGE: number

--- Active sessions for the current script, across servers
declare JD_SESSION_COUNT: number

--- Active sessions for the current key
declare JD_KEY_SESSION_COUNT: number

--- Array of unique Roblox user IDs running the same script in the same server
declare JD_LIVE_USERS: { number }

--- Send an HTTP request without exposing its destination URL in your generated script
declare JD_SECURE_REQUEST: (options: JD_SecureRequestOptions) -> JD_SecureResponse

--- Restricts a value to a literal RE2 pattern inside JD_SECURE_REQUEST
declare JD_SANITIZE: (value: string | number, pattern: string) -> string

--- Enforces length and optional pattern checks on string values inside JD_SECURE_REQUEST
declare JD_VALIDATE: (value: string, options: JD_ValidateOptions) -> string

--- Read verified server-sided key values inside JD_SECURE_REQUEST to prevent spoofing
type BooleanKey = "JD_IS_PREMIUM"
type StringKey =
    "JD_DISCORD_ID"
    | "JD_IP"
    | "JD_COUNTRY_CODE"
    | "JD_KEY"
    | "JD_KEY_CREATED_AT"
    | "JD_KEY_EXPIRES_AT"
    | "JD_SERVICE_NAME"
type NumberKey =
    "JD_KEY_EXECUTIONS"
    | "JD_SCRIPT_EXECUTIONS"
    | "JD_KEY_CREATED_AT_UNIX"
    | "JD_KEY_EXPIRES_AT_UNIX"
    | "JD_SCRIPT_ID"
declare JD_SERVER_VALUE:
    ((name: BooleanKey) -> boolean)
    & ((name: StringKey) -> string)
    & ((name: NumberKey) -> number)

--- Define how a protected script displays notifications sent from Live Sessions
declare JD_NOTIFY: (callback: (
    title: string,
    message: string,
    duration: number,
    kind: JD_NotificationKind
) -> ()) -> ()
