using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.InteropServices;

namespace ArticlesApp.Models
{

    public class Article
    {
        [Key]
        public int Id { get; set; }

        [MinLength(5, ErrorMessage = "Lungimea titlului minima este de 5 caractere")]
        [StringLength(100, ErrorMessage = "Lungimea maxima trebuie sa fie de 100 caractere")]
        [Required(ErrorMessage = "Titlul este obligatoriu")]
        public string Title { get; set; }

        [Required(ErrorMessage = "Continutul articolului este obligatoriu")]
        public string Content { get; set; }
        public DateTime Date { get; set; }

        [Required(ErrorMessage = "Categoria este obligatorie")]
        // cheie externa: un articol face parte dintr-o categorie 
        public int? CategoryId { get; set; }

        
        // PASUL 6: un articol este postat de catre un user
        public string? UserId { get; set; }


        // proprietate virtuala - un articol face parte dintr-o categorie
        public virtual Category? Category { get; set; }

        // PASUL 6: un articol este postat de catre un user
        public virtual ApplicationUser? User { get; set; }

        // proprietate virtuala - un articol poate avea mai multe comentarii
        public virtual ICollection<Comment>? Comments { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem>? Categ { get; set; }
        
    }
}
