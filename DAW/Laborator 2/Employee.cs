using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Laborator_2
{
    internal class Employee
    {
        public int EmployeeId { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public decimal Salary { get; set; }

        public Employee(int employeeId, string firstName, string lastName, decimal salary)
        {
            this.EmployeeId = employeeId;
            this.FirstName = firstName;
            this.LastName = lastName;
            this.Salary = salary;
        }

        public void Index()
        {
            Console.WriteLine("Employee: {0} {1}, Salary: {2}", this.FirstName, this.LastName, this.Salary);
        }
    }

}
