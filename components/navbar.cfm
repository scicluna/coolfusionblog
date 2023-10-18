<div class="bg-slate-500 h-[10dvh] w-full flex items-center justify-between p-4 bg-opacity-80">
    <a href="/cfcblog2" class="text-5xl text-white font-extrabold hover:text-slate-400 transition-all duration-500">Coolest Blog Ever</a>
    
    <!--- If structure --->
    <cfif structKeyExists(session,"user")>
        <a href="/cfcblog2/views/logout.cfm" class="text-white hover:text-slate-400 transition-all duration-500 text-2xl">Logout</a>
    <cfelse>
        <a href="/cfcblog2/views/login.cfm" class="text-white hover:text-slate-400 transition-all duration-500 text-2xl">Login</a>
    </cfif>
</div>