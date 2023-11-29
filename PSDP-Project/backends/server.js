
const express = require('express')
const app = express()
const port = 3000
const mysql2 = require('mysql2')
const bcrypt = require('bcrypt')

const saltRounds = 10;
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const conn = mysql2.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'massage'
});

// if(!conn){
//     console.log("False")
// }else{
//     console.log("True")
// }

app.get('/user', async (req, res) => {
    let sql = "SELECT * FROM register_user"
    await conn.execute(sql,
        (err, result) => {
            if (err) {
                res.status(400).json({
                    message: err.message
                })
                return
            } else {
                res.status(200).json({
                    message: "Connected to Data complet",
                    data: result
                })
            }

        })
})



//Register
app.post("/register", async (req, res) => {
    const { username, password, name, phone, gender, email, address, role, img1, img2, status, price, detail, customer, pay, qr, slip } = req.body
    let sql = "SELECT * FROM register_user WHERE email = ?";
    conn.execute(sql, [email], (err, results) => {
        if (err) {

            return res.status(500).json({
                status: "Error",
                message: "Internal server error",
            });
        } else if (results.length > 0) {
            return res.status(400).json({
                status: "False",
                message: "Email already exists",
            });
        } else {
            bcrypt.genSalt(saltRounds, (err, salt) => {
                bcrypt.hash(password, salt, (err, hash) => {
                    let values = [username, hash, name, phone, gender, email, address, role, img1, img2, status, price, detail, customer, pay, qr, slip];

                    for (let i = 0; i < values.length; i++) {
                        if (values[i] === undefined) {
                            values[i] = null;
                        }
                    }
                    let sql = "INSERT INTO register_user (username, password, name, phone, gender, email, address, role, img1, img2, status, price, detail, customer, pay, qr, slip) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                    conn.execute(sql, values, (err, results) => {
                        if (err) {
                            return res.status(500).json({
                                status: "Error",
                                message: "Internal server error",
                            });
                        } else {
                            return res.status(200).json({
                                status: "True",
                                message: "User created",
                            });
                        }
                    });
                });
            });
        }
    });
});


//หน้าเลือกว่าจะสมัคร user หรือ provider
// app.put("/set_role/:id", async (req, res) => {
//     const { id } = req.params;
//     const {
//         role
//     } = req.body;

//     let sql =
//       "UPDATE register_user SET role = ? WHERE id = ?";
//     conn.execute(
//       sql,
//       [
//         role,
//         id
//       ],
//       (err, results) => {
//         if (err) {
//           res.status(500).json({
//             status: false,
//             message: err.message,
//           });
//           return
//         } else {
//           res.status(200).json({
//             status: true,
//             message: "Success",
//             data: results,
//           });
//         }
//       }
//     );
//   });

// //Login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    let sql = "SELECT * FROM register_user WHERE email = ? ";
    conn.execute(sql, [email], async (err, result) => {
        if (err) {
            res.status(400).json({
                message: err.message
            });
        }
        if (result.length == 0) {
            return res.status(200).json({
                status: "False",
            });
        } else {
            const hashedPassword = result[0].password;
            bcrypt.compare(password, hashedPassword, (err, result) => {
                if (result) {
                    // Find the user role from the database
                    sql = "SELECT id , role FROM register_user WHERE email = ?";
                    conn.execute(sql, [email], (err, result) => {
                        if (err) {
                            return res.status(400).json({
                                message: err.message
                            });
                        } else {
                            return res.status(200).json({
                                status: "True",
                                role: result[0].role,
                                id: result[0].id
                            });
                        }
                    });
                } else {
                    return res.status(200).json({
                        status: "False",
                    });
                }
            });
        }
    })
});

//หน้า post หมอนวด
app.get('/home_provider/:id', async (req, res) => {
    const { id } = req.params
    let sql = "SELECT name, detail, price FROM register_user WHERE id = ?"
    await conn.execute(sql,
        [id],
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

//หน้า post แก้ไขหมอนวด
app.get('/home_provider_edit/:id', async (req, res) => {
    const { id } = req.params
    let sql = "SELECT name FROM register_user WHERE id = ?"
    await conn.execute(sql,
        [id],
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

//กดปุ่ม Post หมอนวด
app.put("/post_status_provider/:id", async (req, res) => {
    const { id } = req.params;
    const {
        status
    } = req.body;

    let sql =
        "UPDATE register_user SET status = ? WHERE id = ?";
    conn.execute(
        sql,
        [
            status,
            id
        ],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    status: false,
                    message: err.message,
                });
                return
            } else {
                res.status(200).json({
                    status: true,
                    message: "Success",
                    data: results,
                });
            }
        }
    );
});

//หน้า edit_Post หมอนวด
app.put("/edit_post_provider/:id", async (req, res) => {
    const { id } = req.params;
    const {
        price,
        detail,
    } = req.body;

    let sql =
        "UPDATE register_user SET price = ?, detail = ? WHERE id = ?";
    conn.execute(
        sql,
        [
            price,
            detail,
            id
        ],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    status: false,
                    message: err.message,
                });
                return
            } else {
                res.status(200).json({
                    status: true,
                    message: "Success",
                    data: results,
                });
            }
        }
    );
});

//หน้าเลือกหมอนวดที่ออนไลน์
app.get('/select_provider', async (req, res) => {

    let sql = "SELECT id, name, price, detail FROM register_user WHERE role = 'provider' AND status = 'online'";

    await conn.execute(sql,
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

//หน้าจองหมอนวด
app.get('/reserve_provider/:id', async (req, res) => {
    const { id } = req.params
    let sql = "SELECT name, detail FROM register_user WHERE id = ?"
    await conn.execute(sql,
        [id],
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

//หน้าจองหมอนวดตอนกดจอง
app.put("/reserve_provider_ok/:id", async (req, res) => {
    const { id } = req.params;
    const {
        status,
        customer
    } = req.body;

    // Make sure all variables have valid values or null
    const statusValue = status !== undefined ? status : null;
    const customerValue = customer !== undefined ? customer : null;

    let sql =
        "UPDATE register_user SET status = ?, customer = ? WHERE id = ?";
    conn.execute(
        sql,
        [
            statusValue,
            customerValue,
            id
        ],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    status: false,
                    message: err.message,
                });
                return
            } else {
                res.status(200).json({
                    status: true,
                    message: "Success",
                    data: results,
                });
            }
        }
    );
});

//หน้า booking user
app.get('/booking_user/:id', async (req, res) => {
    const { id } = req.params
    let sql = "SELECT name, detail, price FROM register_user WHERE customer = ? "
    await conn.execute(sql,
        [id],
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            if (result.length === 0) {
                res.status(404).json({
                    message: "ไม่พบข้อมูล"
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

//หน้าจ่ายเงิน
app.get('/scan_qr/:id', async (req, res) => {
    const { id } = req.params
    let sql = "SELECT qr, price FROM register_user WHERE customer = ?"
    await conn.execute(sql,
        [id],
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            if (result.length === 0) {
                res.status(404).json({
                    message: "ไม่พบข้อมูล"
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

//ปุ่มจ่ายเงิน
app.put("/qr_ok/:id", async (req, res) => {
    const { id } = req.params;
    const {
        pay
    } = req.body;

    let sql =
        "UPDATE register_user SET pay = ? WHERE id = ?";
    conn.execute(
        sql,
        [
            pay,
            id
        ],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    status: false,
                    message: err.message,
                });
                return
            } else {
                res.status(200).json({
                    status: true,
                    message: "Success",
                    data: results,
                });
            }
        }
    );
});

//หน้า booking provider
app.get('/booking_provider/:id', async (req, res) => {
    const { id } = req.params
    let sql = "SELECT id, name, phone, address FROM register_user WHERE pay = 'Success' "
    await conn.execute(sql,
        [id],
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            if (result.length === 0) {
                res.status(404).json({
                    message: "ไม่พบข้อมูล"
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

app.post('/data/:id', (req, res) => {
    const id = req.params.id; // รับค่า id จาก parameter
    const sql = 'SELECT * FROM register_user WHERE id = ?'; // สร้างคำสั่ง SQL สำหรับค้นหาข้อมูลด้วย id

    conn.execute(sql, [id], (err, result) => { // ส่งคำสั่ง SQL ไปที่ฐานข้อมูล
        if (err) { // หากเกิด error
            console.log(err);
            return res.status(500).json({
                status: "Error",
                message: "Internal server error",
            });
        }

        if (result.length === 0) { // หากไม่พบข้อมูล
            return res.status(404).json({
                status: "False",
                message: "Data not found",
            });
        }

        // หากพบข้อมูล
        return res.status(200).json({
            status: "True",
            message: "Data found",
            data: result[0], // ส่งข้อมูลกลับไปใน response
        });
    });
});

//หน้า work_finish
app.get('/work_finish/:id', async (req, res) => {
    const { id } = req.params
    let sql = "SELECT id, name, phone, address FROM register_user WHERE pay = 'Success' AND id = ?"
    await conn.execute(sql,
        [id],
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message: err.message
                })
                return
            }
            if (result.length === 0) {
                res.status(404).json({
                    message: "ไม่พบข้อมูล"
                })
                return
            }
            res.status(200).json({
                message: "เรียกข้อมูลสำเร็จ",
                data: result
            })
        })
})

//หน้า work_finish_user
app.put("/work_finish_user/:id", async (req, res) => {
    const { id } = req.params;
    const {
        pay

    } = req.body;

    let sql =
        "UPDATE register_user SET pay = ? WHERE id = ?";
    conn.execute(
        sql,
        [
            pay,
            id
        ],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    status: false,
                    message: err.message,
                });
                return
            } else {
                res.status(200).json({
                    status: true,
                    message: "Success",
                    data: results,
                });
            }
        }
    );
});

//หน้า work_finish_provider
app.put("/work_finish_provider/:id", async (req, res) => {
    const { id } = req.params;
    const {
        status,
        customer
    } = req.body;

    // Make sure all variables have valid values or null
    const statusValue = status !== undefined ? status : null;
    const customerValue = customer !== undefined ? customer : null;

    let sql =
        "UPDATE register_user SET status = ?, customer = ? WHERE id = ?";
    conn.execute(
        sql,
        [
            statusValue,
            customerValue,
            id
        ],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    status: false,
                    message: err.message,
                });
                return
            } else {
                res.status(200).json({
                    status: true,
                    message: "Success",
                    data: results,
                });
            }
        }
    );
});


app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})