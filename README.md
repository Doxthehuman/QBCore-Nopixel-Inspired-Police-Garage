# QBCore-Nopixel-Inspired-Police-Garage

Preview:
https://streamable.com/jdwcle

Discord:
https://discord.gg/wQBuB3U5Ym

**Requirements**

bt-Target = https://forum.cfx.re/t/release-standalone-target-tracking/2270296


nh-menu = https://forum.cfx.re/t/release-standalone-nerohiro-s-context-menu-dynamic-event-firing-menu/2564083


local peds = {
        `ig_trafficwarden`,
    }
    AddTargetModel(peds, {
        options = {
            {
                event = "garage:menu",
                icon = "fas fa-car",
                label = "Police Garage",
            },
        },
        distance = 2.5
    }) 

for bt-target ^
