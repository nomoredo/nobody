using nobody.core;

namespace nobody.console;

public class NobodyConsole : ImNobody
{
    public void register(Nobody nobody)
    {
        nobody.ctx.RegisterAskHandler((key)=> nobody.AskFor(key));
    }

    public void cleanup(Nobody nobody)
    {

    }
}