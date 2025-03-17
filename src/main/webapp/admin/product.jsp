<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <%@ include file="../components/head.jsp" %>
  <body>
    <%@ include file="../components/sidebar.jsp"%>
    <dialog id="add_product" class="modal">
      <div class="modal-box" style="width: 350px">
      <h3 class="text-lg font-bold flex justify-center">Adding Product</h3>
        <div class="flex justify-center">
          <form method="post" action="${pageContext.request.contextPath}/ProductServlet" enctype="multipart/form-data">
            <fieldset class="fieldset">
              <legend class="fieldset-legend">Product Name</legend>
              <input type="text" class="input" name="name" placeholder="Type here" />
              <p class="fieldset-label">Compulsary</p>
            </fieldset>
            <fieldset class="fieldset">
              <legend class="fieldset-legend">Description</legend>
              <input type="text" class="input" name="description" placeholder="Type here" />
              <p class="fieldset-label">Optional</p>
            </fieldset>
            <fieldset class="fieldset">
              <legend class="fieldset-legend">Price</legend>
              <input type="text" class="input" name="price" placeholder="Type here" />
              <p class="fieldset-label">Compulsary</p>
            </fieldset>
            <fieldset class="fieldset">
              <legend class="fieldset-legend">Stock Quantity</legend>
              <input type="number" class="input" name="quantity" placeholder="Type here" />
              <p class="fieldset-label">Compulsary</p>
            </fieldset>
            <fieldset class="fieldset">
              <legend class="fieldset-legend">Image</legend>
              <input type="file" class="file-input" name="image"/>
              <p class="fieldset-label">Optional</p>
            </fieldset>
            <button type="submit" class="btn btn-secondary w-full mt-4">ADD PRODUCT</button>
          </form>
        </div>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button>close</button>
      </form>
    </dialog>
    <div class="ml-70 font-inter">
      <div class="overflow-x-auto mt-4">
        <table class="table">
          <thead>
          <tr>
            <th>
              <label>
                <input type="checkbox" class="checkbox" />
              </label>
            </th>
            <th>Product Name</th>
            <th>Description</th>
            <th>Price (RM)</th>
            <th>Stock Quantity</th>
            <th>Rating</th>
            <th>Action</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td></td>
            <td class="text-gray col-span-4 justify-left text-md">
              <a href="#" onclick="add_product.showModal()" class="flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus mr-2"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
                Add new product
              </a>
            </td>
          </tr>
          <tr>
            <th>
              <label>
                <input type="checkbox" class="checkbox" />
              </label>
            </th>
            <td>
              <div class="flex items-center gap-3">
                <div class="avatar">
                  <div class="mask mask-squircle h-12 w-12">
                    <img
                            src="https://img.daisyui.com/images/profile/demo/2@94.webp"
                            alt="Avatar Tailwind CSS Component" />
                  </div>
                </div>
                <div>
                  <div class="font-bold">Hart Hagerty</div>
                  <div class="text-sm opacity-50">United States</div>
                </div>
              </div>
            </td>
            <td>
              Zemlak, Daniel and Leannon
              <br />
              <span class="badge badge-ghost badge-sm">Desktop Support Technician</span>
            </td>
            <td>Purple</td>
            <th>
              <button class="btn btn-ghost btn-xs">details</button>
            </th>
          </tr>
          <!-- row 2 -->
          <tr>
            <th>
              <label>
                <input type="checkbox" class="checkbox" />
              </label>
            </th>
            <td>
              <div class="flex items-center gap-3">
                <div class="avatar">
                  <div class="mask mask-squircle h-12 w-12">
                    <img
                            src="https://img.daisyui.com/images/profile/demo/3@94.webp"
                            alt="Avatar Tailwind CSS Component" />
                  </div>
                </div>
                <div>
                  <div class="font-bold">Brice Swyre</div>
                  <div class="text-sm opacity-50">China</div>
                </div>
              </div>
            </td>
            <td>
              Carroll Group
              <br />
              <span class="badge badge-ghost badge-sm">Tax Accountant</span>
            </td>
            <td>Red</td>
            <th>
              <button class="btn btn-ghost btn-xs">details</button>
            </th>
          </tr>
          <!-- row 3 -->
          <tr>
            <th>
              <label>
                <input type="checkbox" class="checkbox" />
              </label>
            </th>
            <td>
              <div class="flex items-center gap-3">
                <div class="avatar">
                  <div class="mask mask-squircle h-12 w-12">
                    <img
                            src="https://img.daisyui.com/images/profile/demo/4@94.webp"
                            alt="Avatar Tailwind CSS Component" />
                  </div>
                </div>
                <div>
                  <div class="font-bold">Marjy Ferencz</div>
                  <div class="text-sm opacity-50">Russia</div>
                </div>
              </div>
            </td>
            <td>
              Rowe-Schoen
              <br />
              <span class="badge badge-ghost badge-sm">Office Assistant I</span>
            </td>
            <td>Crimson</td>
            <th>
              <button class="btn btn-ghost btn-xs">details</button>
            </th>
          </tr>
          <!-- row 4 -->
          <tr>
            <th>
              <label>
                <input type="checkbox" class="checkbox" />
              </label>
            </th>
            <td>
              <div class="flex items-center gap-3">
                <div class="avatar">
                  <div class="mask mask-squircle h-12 w-12">
                    <img
                            src="https://img.daisyui.com/images/profile/demo/5@94.webp"
                            alt="Avatar Tailwind CSS Component" />
                  </div>
                </div>
                <div>
                  <div class="font-bold">Yancy Tear</div>
                  <div class="text-sm opacity-50">Brazil</div>
                </div>
              </div>
            </td>
            <td>
              Wyman-Ledner
              <br />
              <span class="badge badge-ghost badge-sm">Community Outreach Specialist</span>
            </td>
            <td>Indigo</td>
            <th>
              <button class="btn btn-ghost btn-xs">details</button>
            </th>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </body>
</html>
