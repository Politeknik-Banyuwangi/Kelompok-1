<h1>Create Product</h1>
<form action="/products" method="POST">
    @csrf
    Name : <input type="text" name="name"><br>
    Description :<input type="text" name="description"><br>
    Price : <input type="text" name="price"><br>
    Image_url : <input type="file" name="image_url"><br>


    <input type="submit" value="Save">
</form>