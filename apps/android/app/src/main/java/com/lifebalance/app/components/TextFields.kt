package com.lifebalance.app.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Icon
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.lifebalance.app.designsystem.LBColors
import com.lifebalance.app.designsystem.LBRadius
import com.lifebalance.app.designsystem.LBSpacing
import com.lifebalance.app.designsystem.LBTextStyle
import com.lifebalance.app.designsystem.NunitoSans

@Composable
fun LBTextField(
    label: String,
    placeholder: String,
    value: String,
    onValueChange: (String) -> Unit,
    icon: ImageVector? = null,
    isPassword: Boolean = false,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.fillMaxWidth()) {
        Text(
            label.uppercase(),
            style = LBTextStyle.caption.copy(color = LBColors.Foreground.copy(alpha = 0.7f), fontFamily = NunitoSans, fontSize = 12.sp),
            modifier = Modifier.padding(bottom = LBSpacing.xs.dp)
        )
        OutlinedTextField(
            value = value,
            onValueChange = onValueChange,
            placeholder = { Text(placeholder, style = LBTextStyle.body) },
            leadingIcon = icon?.let { { Icon(it, contentDescription = null, tint = LBColors.Primary) } },
            visualTransformation = if (isPassword) PasswordVisualTransformation() else VisualTransformation.None,
            keyboardOptions = KeyboardOptions(keyboardType = if (isPassword) KeyboardType.Password else KeyboardType.Text),
            singleLine = true,
            shape = RoundedCornerShape(LBRadius.input.dp),
            colors = OutlinedTextFieldDefaults.colors(
                focusedContainerColor = LBColors.Surface,
                unfocusedContainerColor = LBColors.Surface,
                focusedBorderColor = LBColors.Primary,
                unfocusedBorderColor = LBColors.Border
            ),
            modifier = Modifier.fillMaxWidth()
        )
    }
}
