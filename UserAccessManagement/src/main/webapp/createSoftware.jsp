<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
    <title>Create Software</title>
    <style>
        .form-container {
            width: 400px;
            background: linear-gradient(#212121, #212121) padding-box,
                        linear-gradient(145deg, transparent 35%,#e81cff, #40c9ff) border-box;
            border: 2px solid transparent;
            padding: 32px 24px;
            font-size: 14px;
            font-family: inherit;
            color: white;
            display: flex;
            margin:auto;
            flex-direction: column;
            gap: 20px;
            box-sizing: border-box;
            border-radius: 16px;
        }

        .form-container button:active {
            scale: 0.95;
        }

        .form-container .form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-container .form-group {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .form-container .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #717171;
            font-weight: 600;
            font-size: 12px;
        }

        .form-container .form-group input {
            width: 100%;
            padding: 12px 16px;
            border-radius: 8px;
            color: #fff;
            font-family: inherit;
            background-color: transparent;
            border: 1px solid #414141;
        }

        .form-container .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border-radius: 8px;
            resize: none;
            color: #fff;
            height: 96px;
            border: 1px solid #414141;
            background-color: transparent;
            font-family: inherit;
        }

        .form-container .form-group input::placeholder {
            opacity: 0.5;
        }

        .form-container .form-group input:focus {
            outline: none;
            border-color: #e81cff;
        }

        .form-container .form-group textarea:focus {
            outline: none;
            border-color: #e81cff;
        }

        .form-container .form-submit-btn {
            display: flex;
            align-items: flex-start;
            justify-content: center;
            align-self: flex-start;
            font-family: inherit;
            color: #717171;
            font-weight: 600;
            width: 40%;
            background: #313131;
            border: 1px solid #414141;
            padding: 12px 16px;
            font-size: inherit;
            gap: 8px;
            margin-top: 8px;
            cursor: pointer;
            border-radius: 6px;
        }

        .form-container .form-submit-btn:hover {
            background-color: #fff;
            border-color: #fff;
        }
    </style>
    <script type="text/javascript">
        function limitCheckboxSelection(checkbox) {
            // Get all checkboxes with the same name
            var checkboxes = document.getElementsByName("accessLevels");

            // Loop through all checkboxes and uncheck them except for the one clicked
            checkboxes.forEach(function(item) {
                if (item !== checkbox) {
                    item.checked = false;
                }
            });
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2>Create Software Application</h2>
        <form action="SoftwareServlet" method="post" class="form">
            <div class="form-group">
                <label for="name">Software Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" cols="50" required></textarea>
            </div>

            <div class="form-group">
                <label for="accessType">Access Levels:</label><br>
                <input type="checkbox" id="read" name="accessLevels" value="Read" onclick="limitCheckboxSelection(this)">
                <label for="read">Read</label><br>

                <input type="checkbox" id="write" name="accessLevels" value="Write" onclick="limitCheckboxSelection(this)">
                <label for="write">Write</label><br>

                <input type="checkbox" id="admin" name="accessLevels" value="Admin" onclick="limitCheckboxSelection(this)">
                <label for="admin">Admin</label><br><br>
            </div>

            <button class="form-submit-btn" type="submit">Add Software</button>
        </form>
    </div>
</body>
</html>
