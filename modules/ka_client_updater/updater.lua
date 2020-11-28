_G.ClientUpdater = { }

local startTime = 0

function ClientUpdater.init()
    ClientUpdater.m = modules.ka_client_updater

    connect(g_updater, {
        onUpdateStart    = ClientUpdater.onUpdateStart,
        onUpdateProgress = ClientUpdater.onUpdateProgress,
        onUpdateEnd      = ClientUpdater.onUpdateEnd,
    })
end

function ClientUpdater.terminate()
    disconnect(g_updater, {
        onUpdateStart    = ClientUpdater.onUpdateStart,
        onUpdateProgress = ClientUpdater.onUpdateProgress,
        onUpdateEnd      = ClientUpdater.onUpdateEnd,
    })

    ClientUpdater.m = nil
end

function ClientUpdater.onUpdateStart()
    startTime = g_clock.millis()
end

function ClientUpdater.onUpdateProgress(receivedObj, totalObj, receivedBytes)
    local percent = (receivedObj/totalObj) * 100
    local deltaTime = (g_clock.millis() - startTime) / 1000
    local avgSpeed = receivedBytes / deltaTime
    print(string.format("%d%% %.2f B/s", percent, avgSpeed))
    print("deltaTime:" .. deltaTime .. ", receivedBytes:" .. receivedBytes)
end

function ClientUpdater.onUpdateEnd()
    g_platform.spawnProcess("Kingdom Age Online.exe", { })
    exit()
end
