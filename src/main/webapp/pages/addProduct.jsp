<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <title>Add Product</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/add.css">

</head>

<body>
    <div class="logoArea">
        LOGO
    </div>

    <div class="productContainer">

        <!-- Back Button -->
        <div class="topRow">
            <a href="${pageContext.request.contextPath}/AdminServlet?action=manageProducts"
               class="backBtn">
                Back
            </a>
        </div>

        <h2>Add Product</h2>

        <form action="${pageContext.request.contextPath}/AdminServlet"
              method="post"
              enctype="multipart/form-data">

            <input type="hidden" name="action" value="addProduct">

            <table class="productTable">

                <tr>
                    <td><label>Product ID</label></td>
                    

                    <td><label>Product Name</label></td>
                    <td><input type="text" name="name" required></td>
                </tr>

                <tr>
                    <td><label>Brand</label></td>
                    <td>
                        <input type="text" name="brand" required>
                    </td>
                </tr>

                <tr>
                    <td><label>Category</label></td>
                    <td><input type="number" name="categoryId" required></td>

                    <td><label>Gender</label></td>
                    <td>
                        <select name="gender">
                            <option value="Men">Men</option>
                            <option value="Women">Women</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td><label>Price</label></td>
                    <td><input type="number" name="price" required></td>

                    <td><label>Stock</label></td>
                    <td><input type="number" name="stock" required></td>
                </tr>

                <tr>
                    <td><label>Description</label></td>
                    <td colspan="3">
                        <textarea name="description" required></textarea>
                    </td>
                </tr>

                <tr>
                    <td><label>Image</label></td>
                    <td colspan="3">
                        <input type="file" name="image" required>
                    </td>
                </tr>
                
                <tr>
                    <td colspan="4" class="btnRow">
                        <button type="submit" class="btn">
                            Add Product
                        </button>
                    </td>
                </tr>

            </table>

        </form>

    </div>

</body>
</html>