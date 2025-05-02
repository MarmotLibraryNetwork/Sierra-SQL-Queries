WITH macros AS (
SELECT
  DISTINCT o.desktop_option_id,
  CASE
    WHEN o.desktop_option_id = '657' THEN 'ALT+F1'
    WHEN o.desktop_option_id = '75' THEN 'ALT+F2'
    WHEN o.desktop_option_id = '379' THEN 'ALT+F3'
    WHEN o.desktop_option_id = '134' THEN 'ALT+F5'
    WHEN o.desktop_option_id = '767' THEN 'ALT+F7'
    WHEN o.desktop_option_id = '195' THEN 'ALT+F8'
    WHEN o.desktop_option_id = '509' THEN 'ALT+F9'
    WHEN o.desktop_option_id = '738' THEN 'ALT+F10'
    WHEN o.desktop_option_id = '158' THEN 'ALT+F11'
    WHEN o.desktop_option_id = '473' THEN 'ALT+F12'
    WHEN o.desktop_option_id = '805' THEN 'CTRL+F1'
    WHEN o.desktop_option_id = '230' THEN 'CTRL+F2'
    WHEN o.desktop_option_id = '559' THEN 'CTRL+F3'
    WHEN o.desktop_option_id = '626' THEN 'CTRL+F6'
    WHEN o.desktop_option_id = '50' THEN 'CTRL+F7'
    WHEN o.desktop_option_id = '362' THEN 'CTRL+F8'
    WHEN o.desktop_option_id = '698' THEN 'CTRL+F9'
    WHEN o.desktop_option_id = '23' THEN 'CTRL+F10'
    WHEN o.desktop_option_id = '342' THEN 'CTRL+F11'
    WHEN o.desktop_option_id = '673' THEN 'CTRL+F12'
    WHEN o.desktop_option_id = '424' THEN 'F1'
    WHEN o.desktop_option_id = '757' THEN 'F2'
    WHEN o.desktop_option_id = '500' THEN 'F4'
    WHEN o.desktop_option_id = '814' THEN 'F5'
    WHEN o.desktop_option_id = '574' THEN 'F7'
    WHEN o.desktop_option_id = '313' THEN 'F9'
    WHEN o.desktop_option_id = '354' THEN 'F11'
    WHEN o.desktop_option_id = '357' THEN 'SHIFT+F1'
    WHEN o.desktop_option_id = '696' THEN 'SHIFT+F2'
    WHEN o.desktop_option_id = '411' THEN 'SHIFT+F4'
    WHEN o.desktop_option_id = '169' THEN 'SHIFT+F6'
    WHEN o.desktop_option_id = '488' THEN 'SHIFT+F7'
    WHEN o.desktop_option_id = '807' THEN 'SHIFT+F8'
    WHEN o.desktop_option_id = '233' THEN 'SHIFT+F9'
    WHEN o.desktop_option_id = '374' THEN 'SHIFT+F10'
    WHEN o.desktop_option_id = '707' THEN 'SHIFT+F11'
    WHEN o.desktop_option_id = '124' THEN 'SHIFT+F12'
  END AS macro
    
FROM
sierra_view.iii_user_desktop_option o
WHERE o.desktop_option_id IN
('757','424','807','814','574','500','169','313','509','696','233','75','767','158','374','342','707','124','657','473','354','626','23','362','134','50','357','738','488','698','559','805','411','230','379','195','673')
ORDER BY 2
)
SELECT
  u.name,
  m.macro AS hotkey,
  o.value AS macro
FROM macros m
JOIN sierra_view.iii_user_desktop_option o
  ON m.desktop_option_id = o.desktop_option_id
  AND o.value != ''
JOIN sierra_view.iii_user u
  ON o.iii_user_id = u.id
ORDER BY 1,2