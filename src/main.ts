export class MyClass {} //cause lualib import

declare let main: () => void;
const oldMain = main;
main = () => {
    oldMain();
    const pl = Player(0);
    if (!pl) return;
    const t = CreateTimer();
    TimerStart(t, 0, false, () => {
        PauseTimer(t);
        DestroyTimer(t);
        print("Hello World!");
    });
};
