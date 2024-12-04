using System.ComponentModel.DataAnnotations;

namespace ArticlesApp.Models
{
    public class Comment
    {
        [Key]
        public int? Id { get; set; }

        [Required(ErrorMessage = "Continutul este obligatoriu")]
        public string Content { get; set; }

        public DateTime? Date { get; set; }

        // cheie externa - un comentariu este legat de un articol
        public int? ArticleId { get; set; }

        // PASUL 6: un comentariu este postat de catre un user
        public string? UserId { get; set; }


        // proprietate virtuala - un comentariu este legat de un articol
        public virtual Article? Article { get; set; }

        // proprietate virtuala - un comentariu este postat de un user
        public virtual ApplicationUser? User { get; set; }
    }

}
