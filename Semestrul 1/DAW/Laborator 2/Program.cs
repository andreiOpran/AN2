using Laborator_2;

namespace Laborator2
{
    class Program
    {
        static void Palindrom(int n)
        {
            int cn = n;
            int ogl = 0;
            while   (cn != 0)
            {
                ogl = ogl * 10 + cn % 10;
                cn /= 10;
            }
            if (ogl == n)
                Console.WriteLine("Numarul este palindrom");
            else
                Console.WriteLine("Numarul nu este palindrom");
            
        }

        static void VectorAlternant(int[] v, int n)
        {
            int i;
            for (i = 0; i < n - 1; i++)
                if (v[i] % 2 == v[i + 1] % 2)
                    break;
            if (i == n - 1)
                Console.WriteLine("Vectorul este alternant");
            else
                Console.WriteLine("Vectorul nu este alternant");
        }

        static void Main(string[] args)
        {

            // PALINDROM

            //int n;

            // var p = new Program(); // pt palindrom nestatic
            // p.Palindrom(n);

            //Console.WriteLine("Enter a number: ");
            //n = Convert.ToInt32(Console.ReadLine());

            //Palindrom(n);


            // VECTOR ALTERNANT

            Console.WriteLine("Introdu elementele vectorului separate prin spatiu: ");
            string[] input = Console.ReadLine().Split(' ');
            
            int nrElem = input.Length;
                                                                     
            int[] v = new int[nrElem];
            for (int i = 0; i < nrElem; i++)
                v[i] = Convert.ToInt32(input[i]);
            
            VectorAlternant(v, nrElem);

            //for(int i = 0; i < nrElem; i++) // AFISARE VECTOR PE UN RAND
            //    Console.Write(v[i] + " ");

            // int[] v = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
            // int nrElem = 10;
            //

            //VectorAlternant(v, nrElem);


            // CLASA EMPLOYEE

            //var employee = new Employee(1, "John", "Doe", 1000);
            //employee.Index();

        }
    }
}