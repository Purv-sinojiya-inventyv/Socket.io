const io = require('socket.io')(3000, {
    cors: { origin: "*" }
});

io.on("connection", socket => {
    console.log(" New client connected");

    socket.on("message", msg => {
        console.log(" Received:", msg);
        io.emit("message", "Hello from Server!");
    });

    socket.on("disconnect", () => {
        console.log(" Client disconnected");
    });
});
