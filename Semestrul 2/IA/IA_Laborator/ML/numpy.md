# NumPy Functions Cheatsheet

## Array Creation

```python
# Creating arrays
np.array([1, 2, 3])               # Create array from list
np.zeros((3, 4))                  # Create 3x4 array of zeros
np.ones((2, 3, 4))                # Create 2x3x4 array of ones
np.empty((2, 3))                  # Create uninitialized 2x3 array
np.arange(10)                     # Array from 0 to 9
np.arange(2, 10, 2)               # Array from 2 to 8, step 2
np.linspace(0, 1, 5)              # 5 evenly spaced values from 0 to 1
np.random.random((2, 3))          # Random values in 2x3 array
np.random.randn(2, 3)             # Gaussian random values
np.random.randint(0, 10, (3, 3))  # Random integers between 0 and 9
np.eye(3)                         # 3x3 identity matrix
```

## Array Properties and Methods

```python
# Basic properties
arr = np.array([[1, 2, 3], [4, 5, 6]])
arr.shape                         # (2, 3) - dimensions
arr.ndim                          # 2 - number of dimensions
arr.size                          # 6 - total number of elements
arr.dtype                         # Data type of elements
arr.itemsize                      # Size of each element in bytes
arr.nbytes                        # Total memory used in bytes

# Reshaping arrays
arr.reshape(3, 2)                 # Reshape to 3x2 array
arr.flatten()                     # Flatten to 1D array
arr.ravel()                       # Flatten to 1D array (view if possible)
arr.transpose()                   # Transpose dimensions
# Swap first and second axes
transposed1 = np.transpose(input_array, (1, 0, 2))  # Now: width, height, channels
arr.T                             # Shorthand for transpose
```

## Array Manipulation

```python
# Indexing and slicing
arr = np.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
arr[0, 1]                         # Element at row 0, col 1 (= 2)
arr[0:2, 1:3]                     # Slicing rows 0-1, cols 1-2
arr[:, 1]                         # All rows, column 1
arr[1, ...]                       # Row 1, all remaining dimensions
arr[::-1, ::-1]                   # Reverse both dimensions

# Adding/removing elements
np.append(arr, [[13, 14, 15, 16]], axis=0)  # Append row
np.insert(arr, 1, [100, 101, 102, 103], axis=0)  # Insert at index 1
np.delete(arr, 1, axis=0)         # Delete row at index 1

# Combining arrays
a = np.array([[1, 2], [3, 4]])
b = np.array([[5, 6], [7, 8]])
np.concatenate((a, b), axis=0)    # Vertical concatenation
np.vstack((a, b))                 # Same as above
np.concatenate((a, b), axis=1)    # Horizontal concatenation
np.hstack((a, b))                 # Same as above
np.stack((a, b), axis=2)          # Stack along new axis

# Splitting arrays
arr = np.arange(16).reshape(4, 4)
np.split(arr, 2, axis=0)          # Split into 2 equal parts (rows)
np.split(arr, 2, axis=1)          # Split into 2 equal parts (columns)
np.hsplit(arr, 2)                 # Horizontal split (along columns)
np.vsplit(arr, 4)                 # Vertical split (along rows)
```

## Mathematical Operations

```python
# Basic operations
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])
a + b                             # Element-wise addition
a - b                             # Element-wise subtraction
a * b                             # Element-wise multiplication
a / b                             # Element-wise division
a ** 2                            # Element-wise exponentiation
a @ b                             # Dot product (same as np.dot(a, b))

# Universal functions
np.add(a, b)                      # Same as a + b
np.subtract(a, b)                 # Same as a - b
np.multiply(a, b)                 # Same as a * b
np.divide(a, b)                   # Same as a / b
np.power(a, 2)                    # Same as a ** 2
np.sqrt(a)                        # Square root
np.exp(a)                         # e^x for each element
np.log(a)                         # Natural log
np.sin(a), np.cos(a), np.tan(a)   # Trigonometric functions
np.abs(a)                         # Absolute value

# Comparison operations
a > b                             # Element-wise comparison (returns boolean array)
a == b                            # Element-wise equality check
np.array_equal(a, b)              # True if arrays have same shape and elements
```

## Statistical Functions

```python
arr = np.array([[1, 2, 3], [4, 5, 6]])

# Basic statistics
np.sum(arr)                       # Sum of all elements (21)
np.sum(arr, axis=0)               # Sum of each column [5, 7, 9]
np.sum(arr, axis=1)               # Sum of each row [6, 15]

np.mean(arr)                      # Mean of all elements (3.5)
np.mean(arr, axis=0)              # Mean of each column
np.mean(arr, axis=1)              # Mean of each row

np.std(arr)                       # Standard deviation of all elements
np.std(arr, axis=0)               # Standard deviation of each column
np.var(arr)                       # Variance of all elements

np.min(arr)                       # Minimum value (1)
np.max(arr)                       # Maximum value (6)
np.argmin(arr)                    # Index of minimum value (flattened)
np.argmax(arr)                    # Index of maximum value (flattened)
np.min(arr, axis=0)               # Min of each column [1, 2, 3]
np.max(arr, axis=1)               # Max of each row [3, 6]

np.median(arr)                    # Median value (3.5)
np.percentile(arr, 75)            # 75th percentile
```

## Boolean Operations and Filtering

```python
arr = np.array([1, 2, 3, 4, 5])
mask = arr > 2                    # Creates boolean array [False, False, True, True, True]
arr[mask]                         # Filter array using mask: returns [3, 4, 5]
arr[arr > 2]                      # Same as above, more concise

# Logical operations on boolean arrays
a = np.array([True, False, True])
b = np.array([False, True, True])
np.logical_and(a, b)              # Element-wise AND
np.logical_or(a, b)               # Element-wise OR
np.logical_not(a)                 # Element-wise NOT
np.logical_xor(a, b)              # Element-wise XOR

# Counting and finding
np.count_nonzero(arr > 2)         # Count elements that satisfy condition (3)
np.any(arr > 4)                   # True if any element satisfies condition
np.all(arr > 0)                   # True if all elements satisfy condition
np.where(arr > 2)                 # Return indices where condition is True
np.where(arr > 2, arr, -1)        # If True return arr value, else -1
```

## Linear Algebra

```python
a = np.array([[1, 2], [3, 4]])
b = np.array([[5, 6], [7, 8]])

np.dot(a, b)                      # Matrix multiplication
a @ b                             # Same as above (Python 3.5+)
np.linalg.det(a)                  # Determinant
np.linalg.inv(a)                  # Inverse
np.linalg.eig(a)                  # Eigenvalues and eigenvectors
np.linalg.svd(a)                  # Singular value decomposition
np.linalg.norm(a)                 # Frobenius norm
np.linalg.solve(a, np.array([1, 2]))  # Solve linear system Ax = b
```

## File I/O

```python
# Saving and loading arrays
arr = np.array([1, 2, 3, 4, 5])
np.save('myarray', arr)           # Save as binary .npy file
np.load('myarray.npy')            # Load .npy file

# Multiple arrays
np.savez('arrays.npz', a=arr, b=arr*2)  # Save multiple arrays
data = np.load('arrays.npz')      # Load npz file
data['a']                         # Access array 'a'

# Text files
np.savetxt('array.txt', arr)      # Save to text file
np.loadtxt('array.txt')           # Load from text file
np.genfromtxt('data.csv', delimiter=',')  # Load with more options
```

## Image Processing with NumPy

```python
# Image as numpy array (assuming grayscale)
img = np.zeros((400, 600))        # Create blank image
img[100:300, 200:400] = 255       # Set white rectangle

# Image operations
img_mean = np.mean(img)           # Average pixel value
img_std = np.std(img)             # Standard deviation of pixel values
normalized_img = (img - img_mean) / img_std  # Normalize image

# Image cropping
cropped = img[200:300, 280:400]   # Crop to specific region

# Image transformations
flipped_h = img[:, ::-1]          # Flip horizontally
flipped_v = img[::-1, :]          # Flip vertically
rotated = np.rot90(img)           # Rotate 90 degrees
```

## Tips and Tricks

```python
# Broadcasting - automatic extension of smaller arrays
a = np.array([1, 2, 3])
b = np.array([[1], [2], [3]])
a + b                             # Result is 3x3 array

# Using axis parameter effectively
arr = np.array([[1, 2, 3], [4, 5, 6]])
np.sum(arr, axis=0)               # Sum columns: [5, 7, 9]
np.sum(arr, axis=1)               # Sum rows: [6, 15]

# Fast element-wise operations
np.exp(arr)                       # Much faster than [math.exp(x) for x in arr]

# Vectorization example
def slow_function(arr):
    result = np.zeros_like(arr)
    for i in range(len(arr)):
        result[i] = arr[i] ** 2 + 2 * arr[i] + 1
    return result

def fast_function(arr):
    return arr ** 2 + 2 * arr + 1  # Vectorized version
```

## Memory Management

```python
# Views vs copies
a = np.array([[1, 2, 3], [4, 5, 6]])
b = a                             # b is a view (reference) of a
b[0, 0] = 99                      # Changes a as well
c = a.copy()                      # c is a deep copy of a
c[0, 0] = 88                      # Doesn't affect a

# Memory optimization
a = np.zeros((1000, 1000), dtype=np.float32)  # Uses 4MB
b = np.zeros((1000, 1000), dtype=np.float64)  # Uses 8MB

# Check memory usage
a.nbytes                          # Total bytes consumed by array elements
```

## Common NumPy Errors to Watch Out For

1. **Broadcasting errors**: When shapes are incompatible for broadcasting
2. **Index out of bounds**: Accessing elements outside array dimensions
3. **Type conversion issues**: Unexpected behavior due to implicit type conversion
4. **Memory errors**: Working with arrays too large for available memory
5. **Performance bottlenecks**: Using loops instead of vectorized operations