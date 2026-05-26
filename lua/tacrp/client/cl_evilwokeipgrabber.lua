--//////////--
-- This script uses ip-api.com to fetch the user's country of origin and nothing else. You can read ip-api.com's privacy policy here: https://ip-api.com/docs/legal
--//////////--

local testCountry = nil

local names = {
    DE = "Germany",
    FR = "France",
    GB = "the United Kingdom",
    IE = "Ireland",
    NL = "the Netherlands",
    ES = "Spain",
    SE = "Sweden",
    FI = "Finland",
    DK = "Denmark",
    NO = "Norway",
    IT = "Italy",
    AT = "Austria",
    CH = "Switzerland",
    BE = "Belgium",
    PL = "Poland",
    CZ = "Czechia",

    US = "the United States",
    CA = "Canada",
    AU = "Australia",
    NZ = "New Zealand",

    BR = "Brazil",
    AR = "Argentina",
    CL = "Chile",
    MX = "Mexico",
    CO = "Colombia",
    PE = "Peru",

    ZA = "South Africa",
    KE = "Kenya",
    UG = "Uganda",
    NG = "Nigeria",

    JP = "Japan",
    TW = "Taiwan",
    IN = "India",
    PH = "the Philippines",
    TH = "Thailand",
    KR = "South Korea",
    HK = "Hong Kong",
    SG = "Singapore",
    ID = "Indonesia",
    MY = "Malaysia"
}

local cols = {
    Color(255, 120, 120),
    Color(255, 180, 110),
    Color(255, 235, 140),
    Color(120, 200, 140),
    Color(120, 170, 255),
    Color(180, 130, 220)
}

local function msgText(txt)
    local out = {}
    local step = 5

    for i = 1, #txt, step do
        local col = cols[(math.floor((i - 1) / step) % #cols) + 1]

        out[#out + 1] = col
        out[#out + 1] = txt:sub(i, i + step - 1)
    end

    return out
end

local function sayMsg(txt)
    local out = {}

    for _, part in ipairs(msgText(txt)) do
        out[#out + 1] = part
    end

    chat.AddText(unpack(out))
end

hook.Add("InitPostEntity", "WokeMsg", function()
    timer.Simple(3, function()
        http.Fetch(
            "http://ip-api.com/json/?fields=status,country,countryCode", -- This is an HTTP request that cannot ascertain any information about you other than your country of origin. Google tracks you more than this does.
            function(body)
                local geo = util.JSONToTable(body)
                if not geo or geo.status ~= "success" then return end

                local code = string.upper(testCountry or geo.countryCode or "")
                local country = names[code] or geo.country or "your region"

                sayMsg("TacRP is made by queer folk! Support LGBTQ+ rights in " .. country .. "!")
            end,
            function(err)
                print("erm" .. tostring(err))
            end
        )
    end)
end)