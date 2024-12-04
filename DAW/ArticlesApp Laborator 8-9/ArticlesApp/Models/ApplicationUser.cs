using Microsoft.AspNetCore.Identity;

// PAS 1: useri si roluri 

namespace ArticlesApp.Models
{
    public class ApplicationUser : IdentityUser
    {
        // PASUL 6: useri si roluri

        // un user posteaza mai multe articole
        public virtual ICollection<Article>? Articles { get; set; }

        // un user posteaza mai multe comentarii
        public virtual ICollection<Comment>? Comments { get; set; }
    
    }
}
