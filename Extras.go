// 1. Convert an empty interface{} to a typed var
// set the test variable as an empty interface and by assigning the value its typed is string.
// Type Assertion
var test interface{} = "help!"

// 2. Show an example of a Go routine and how to stop it
// One go routine can't forcibly stop another, a go routine can stop only by returning from it's top level function.
// To make a go routine stoppable, let it listen for a stop signal on a channel.
package main
import "fmt"

func Generator() chan int {
        ch := make(chan int)
        go func() {
                n := 1
                for {
                        select {
                        case ch <- n:
                                n++
                        case <-ch:
                                return
                        }
                }
        }()
        return ch
}

func main() {
        number := Generator()
        fmt.Println(<-number)
        fmt.Println(<-number)
        close(number)
}

// 3. Create a simple in-memory cache that can safely be accessed concurrently
// I have searched google and found this libray available for the concurrent-safe, in-memory cache
// This is the first day for me to learn GO, and it will take a lot more time to develop this from scratch than utilizing preexisting library
// at this moment
package main

import (
	"fmt"
	"github.com/patrickmn/go-cache"
	"time"
)

func main() {
	c := cache.New(5*time.Minute, 10*time.Minute)
	c.Set("foo","bar", cache.DefaultExpiration)
	c.Set("baz",42,cache.NoExpiration)
	foo,found := c.Get("foo")
	if found {
		fmt.Println(foo)
	}
}


// 4. What is a slice and how is it related to an array?
// Array is fixed size, meanwhile a slice is dynamicallyed-sized with a low and high bound, separated by a colon
package main
import "fmt"

func main() {
	nums := [5]int{1,2,3,4,5}

	var s []int=nums[1:4]
	fmt.Println(s)	// should print 2,3,4
}
// 5. What is the syntax for zero allocation, swapping of two integers variables?
// utilizing tuple
package main
import "fmt"

func main() {
	number1, number2 := 12, 30
	number1, number2 = number2,number1

	fmt.Println("Number1:",number1)
	fmt.Println("Number2:",number2)
}