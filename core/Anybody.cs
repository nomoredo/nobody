using Serilog.Events;

namespace nobody.core;

public abstract class Anybody
{
     public Ctx ctx => Nobody.ctx_static;
    protected  AnyLogger log => ctx.maybe_service<AnyLogger>("logger") ?? new NoLog();

     protected Anybody()
     {
         log.Information("Anybody created");
     }
}

