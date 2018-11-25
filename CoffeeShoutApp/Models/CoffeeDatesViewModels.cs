using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CoffeeShoutApp.Models
{
    public class CoffeeDatesViewModels
    {
        public List<Member> Members { get; set; }
        public List<CoffeeDate> CoffeeDates { get; set; }
    }
}