--!strict

--- Whether the player has Premium access
declare JD_IS_PREMIUM: boolean

--- Use this instead of JD_EXPIRES_AT to detect keyless access
declare JD_REASON: "KEY_VALID" | "KEYLESS"

--- Public token of the current script
declare JD_SCRIPT_ID: string

--- Key creation time in Unix seconds, nil if data isn't available ig
declare JD_CREATED_AT: number?

--- Key expiration time in Unix seconds, nil for lifetime, keyless, or unavailable data
declare JD_EXPIRES_AT: number?

--- Executor hwid id used for HWID binding when available
declare JD_FINGERPRINT: string?

--- Linked Discord user ID when available
declare JD_DISCORD_ID: string?

--- Stored Discord username when available
declare JD_DISCORD_USERNAME: string?

--- Display name alias currently the same stored name as JD_DISCORD_USERNAME
declare JD_DISCORD_DISPLAY_NAME: string?

--- Discord avatar url
declare JD_DISCORD_PFP: string?

--- Execution count for the current key across scripts
declare JD_EXECUTIONS: number

--- Execution count for the current script across whole yeah
declare JD_SCRIPT_EXECUTIONS: number

--- Accumulated runtime for the current key in seconds
declare JD_USAGE: number

--- Accumulated runtime for the current script in seconds
declare JD_SCRIPT_USAGE: number

--- Active sessions for the current script across servers
declare JD_SESSION_COUNT: number

--- Active sessions for the current key
declare JD_KEY_SESSION_COUNT: number

--- Unique Roblox user IDs running this script in this server
declare JD_LIVE_USERS: { number }

--- Secure HTTP request macro (similar to Luarmor's Secure Request macro)
declare JD_SECURE_REQUEST: (options: {
    Url: string,
    Method: ("GET" | "POST" | "PUT" | "PATCH" | "DELETE" | "HEAD" | "OPTIONS")?,
    Headers: { [string]: string }?,
    Body: any,
    Params: { [string]: any }?,
    Limits: {
        PerKey: number?,
        PerIp: number?,
    }?,
}) -> {
    Success: boolean,
    StatusCode: number,
    StatusMessage: string,
    Headers: { [string]: string },
    Body: string,
}

--- Validate a string or whole number against a literal RE2 pattern inside JD_SECURE_REQUEST
declare JD_SANITIZE: (value: string | number, pattern: string) -> string

--- Validate a string inside JD_SECURE_REQUEST, MaxLength is from 1 to 16384
declare JD_VALIDATE: (value: string, options: {
    MaxLength: number,
    Pattern: string?,
}) -> string

--- Read verified server sided key values inside JD_SECURE_REQUEST to prevent spoofing
declare JD_SERVER_VALUE:
    ((name: "JD_IS_PREMIUM") -> boolean)
    & ((name: "JD_DISCORD_ID") -> string)

--- Define one top level anonymous notification callback, duration is in seconds
declare JD_NOTIFY: (callback: (
    title: string,
    message: string,
    duration: number,
    kind: "Info" | "Success" | "Warning" | "Error"
) -> ()) -> ()
